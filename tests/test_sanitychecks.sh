#!/usr/bin/env bash

export test_description="Testing 'pass import'"
cd tests
source ./commons.sh

test_expect_success "Testing store not initialized" "
    test_must_fail _pass import keepass $DB/keepass.xml
    "

test_init "sanitychecks" &> /dev/null
test_expect_success "Testing import from stdin" "
    cat $DB/keepass.xml | _pass import keepass
    "

test_expect_success "Testing import from not a file" "
    test_must_fail _pass import lastpass ImNotAFile
    "

test_expect_success 'Testing corner cases' '
    test_must_fail _pass import --not-an-option &&
    test_must_fail _pass import not-a-manager &&
    _pass import --list
    '

test_expect_success 'Testing help message' '
    _pass import --help | grep "[manager] [file]" &&
    _pass import --version | grep "pass import 2.4"
    '

test_done
