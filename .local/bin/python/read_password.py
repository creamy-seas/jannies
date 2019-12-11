#!/usr/bin/python
from subprocess import check_output
import os
import argparse
import re


def get_password_emacs(user, verbose=True):

    # 1 - prepare regexp
    s = "%s password ([^ ]*)\n" % (user)
    p = re.compile(s)
    if(verbose):
        print(s)
        print("==> Prompting for password")

    # 2 - kill pinentry programs which tend to stall on the mac
    os.system("killall pinentry 2> /dev/null")

    # 3 - get password
    authinfo = os.popen(
        "gpg -q --no-tty -d ~/mail/.pswd_mail.gpg").read()

    # 4 - return
    if(verbose):
        print("==> Returning password")
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
