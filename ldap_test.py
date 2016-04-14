#!/usr/bin/env python
# -*- coding: UTF-8 -*-
# need ldap3, ldap-utils, python-ldap package
import os
import sys
import ldap

def login_ldap(username, password, domainname, com, server):
    try:
        print("Start")
        Server = server
        baseDN = "dc=%s,dc=%s" % (domainname, com)
        print baseDN
        searchScope = ldap.SCOPE_SUBTREE
        # setup filter
        searchFilter = "sAMAccountName=" + username
        # add domain for user
        username = '%s%s\\' % (domainname,com) + username
        print username


        # None search all attribute，['cn'] only search cn
        retrieveAttributes = None

        conn = ldap.initialize(Server)
        conn.set_option(ldap.OPT_REFERRALS, 0)
        conn.protocol_version = ldap.VERSION3
        # the username is the fully  domain/name
        print conn.simple_bind_s(username, password)
        print 'ldap connect successfully'


        # call search to return id
        ldap_result_id = conn.search(baseDN, searchScope, searchFilter, retrieveAttributes)
        result_set = []
        print ldap_result_id

        print("****************")
        while 1:
            result_type, result_data = conn.result(ldap_result_id, 0)
            if(result_data == []):
                break
            else:
                if result_type == ldap.RES_SEARCH_ENTRY:
                    result_set.append(result_data)

        #print result_set
        Name,Attrs = result_set[0][0]
        if hasattr(Attrs, 'has_key') and Attrs.has_key('name'):
            print("test3")
            distinguishedName = Attrs['mail'][0]
            #distinguishedName = Attrs['name'][0]
            #distinguishedName = Attrs['displayName'][0]
            #distinguishedName = Attrs['mail'][0]
            #distinguishedName = Attrs['memberOf'][0]
            #distinguishedName = Attrs['mailNickname'][0]
            #distinguishedName = Attrs['sAMAccountName'][0]
            #distinguishedName = Attrs['distinguishedName'][0]
            #distinguishedName = Attrs['title'][0]
            #distinguishedName = Attrs['department'][0]
            #distinguishedName = Attrs['manager'][0]
            print "Login Info for user : %s" % distinguishedName

            print Attrs['mail'][0]
            print Attrs['name'][0]
            print Attrs['displayName'][0]
            print Attrs['memberOf'][0]
            print Attrs['sAMAccountName'][0]
            print Attrs['title'][0]
            print Attrs['department'][0]

            return distinguishedName

        else:
            print("in error")
            return None
    except ldap.LDAPError, e:
        print("out error")
        print e
        return None

if __name__ == "__main__":
    username = "testuser" # ldap username
    password = "testpasswd" # ldap password
    domainname = 'domain'
    com = 'org'
    server = "ldap://ldap.domain.org:3268"

    login_ldap(username, password, domainname, com, server)
