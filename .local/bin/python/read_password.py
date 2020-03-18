#!/usr/bin/python
from subprocess import check_output
import os
import argparse
import re


class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


def print_colored(text, colour=bcolors.OKGREEN):
    print(colour + text + bcolors.ENDC)


def get_password_emacs(user, verbose=True):

    # 1 - prepare regexp ######################################################
    s = "%s password ([^ ]*)\n" % (user)
    p = re.compile(s)

    # 2 - kill pinentry programs which tend to stall on the mac ###########
    os.system("killall pinentry 2> /dev/null")

    # 3 - get password ########################################################
    authinfo = os.popen(
        "gpg -q --no-tty -d ~/db_mail/.pswd_mail.gpg").read()

    # 4 - return ##############################################################
    return p.search(authinfo).group(1)


def get_pswd(path):
    return check_output(['gpg', '--quiet', '--batch', '-d', os.path.expanduser(path)]).strip()


if (__name__ == '__main__'):
    ap = argparse.ArgumentParser()
    ap.add_argument("-u", "--user", required=True,
                    help="user")
    args = vars(ap.parse_args())

    print(get_password_emacs(args['user'], verbose=False))
    # print(str(get_pswd("~/mail/.pswd_mail.gpg")), "utf-8")
