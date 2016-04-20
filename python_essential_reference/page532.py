# -*- coding: utf-8 -*-
"""
    python_essential_reference.page532
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Pool of processes.

    :copyright: (c) 2016 by Rambler&Co.
"""
import hashlib
import multiprocessing
import os

BUFSIZE = 8192
PROCESS_NUMBER = 2


def compute_digest(filename):
    try:
        f = open(filename, 'rb')
    except IOError:
        return None
    else:
        digest = hashlib.sha512()
        while True:
            chunk = f.read(BUFSIZE)
            if not chunk:
                break
            digest.update(chunk)

        f.close()
        return filename, digest.digest()


def build_digest_map(topdir):
    pool = multiprocessing.Pool(PROCESS_NUMBER)
    allfiles = (os.path.join(path, name)
                for path, dirs, files in os.walk(topdir)
                for name in files)

    digest_map = dict(pool.imap_unordered(compute_digest, allfiles, 20))
    pool.close()
    return digest_map


if __name__ == '__main__':
    digest_map = build_digest_map(os.path.abspath(os.pardir))
    print(len(digest_map))
