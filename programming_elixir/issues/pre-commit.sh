#!/bin/sh

# credo checks before commit
mix credo
CREDO_RES=$?
if [ $CREDO_RES -ne 0 ]
then
  exit $CREDO_RES
fi

# tests
mix test
TEST_RES=$?
if [ $TEST_RES -ne 0 ]
then
  exit $TEST_RES
fi
