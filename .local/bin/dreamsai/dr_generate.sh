#!/usr/bin/env bash

#  ___              _          _  _ 
# |_ _| _ __   ___ | |_  __ _ | || |
#  | | | '_ \ / __|| __|/ _` || || |
#  | | | | | |\__ \| |_| (_| || || |
# |___||_| |_||___/ \__|\__,_||_||_|
#                                   
#
# pdfgrep

FOLDER_LOCATION="/Users/CCCP/gdrive/bureucracy/payments/_base/"
DROPBOX_LOCATION="/Users/CCCP/Dropbox"
cd $FOLDER_LOCATION

# 1 - extract the line with the employee code and parse it
CHOSEN_LINE=$(cat name_table.txt | grep $1)
IFS=" " read CODE NAME POSITION JOB PASSPORT TELEPHONE SORTCODE ACCOUNT<<< $CHOSEN_LINE

# 2 - remove underscores
NAME="${NAME//_/ }"
POSITION="${POSITION//_/ }"
JOB="${JOB//_/ }"

echo "==> Generating document for" $NAME for £$2

# 3 - sub into document
cp -f acknowledgment_receipt_template.tex acknowledgment_receipt.tex
echo "==> Subbing in"
sed -i "" "s|^.*new.*\\today.*|\\\\newcommand{\\\\reference}{\\\\specialdate\\\\today-$CODE}|g" acknowledgment_receipt.tex 
sed -i "" "s|^.*new.*\\passport.*|\\\\newcommand{\\\\passport}{$PASSPORT}|g" acknowledgment_receipt.tex 
sed -i "" "s|^.*new.*\\itelephone.*|\\\\newcommand{\\\\itelephone}{$TELEPHONE}|g" acknowledgment_receipt.tex 
sed -i "" "s|^.*new.*\\iname.*|\\\\newcommand{\\\\iname}{$NAME}|g" acknowledgment_receipt.tex 
sed -i "" "s|^.*new.*\\position.*|\\\\newcommand{\\\\position}{$POSITION}|g" acknowledgment_receipt.tex 
sed -i "" "s|^.*new.*\\job.*|\\\\newcommand{\\\\job}{$JOB}|g" acknowledgment_receipt.tex 
sed -i "" "s|^.*new.*\\amount.*|\\\\newcommand{\\\\amount}{$2}|g" acknowledgment_receipt.tex 


echo "==> Building pdf"
pdflatex -interaction=nonstopmode acknowledgment_receipt.tex >> /dev/null
REF=$(pdfgrep 'Reference:' acknowledgment_receipt.pdf | awk '{print $2}')
mv acknowledgment_receipt.pdf "$DROPBOX_LOCATION/$REF.pdf"

echo "==> Copying to clipboard"
clipboard.oa "$DROPBOX_LOCATION/$REF.pdf"

echo "Sort-code:  $SORTCODE"
echo "Account:    $ACCOUNT"
echo "Refference: $REF"
