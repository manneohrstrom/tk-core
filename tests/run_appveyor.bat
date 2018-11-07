:: Copyright (c) 2018 Shotgun Software Inc.
::
:: CONFIDENTIAL AND PROPRIETARY
::
:: This work is provided "AS IS" and subject to the Shotgun Pipeline Toolkit
:: Source Code License included in this distribution package. See LICENSE.
:: By accessing, using, copying or modifying this work you indicate your
:: agreement to the Shotgun Pipeline Toolkit Source Code License. All rights
:: not expressly granted therein are reserved by Shotgun Software Inc.

::
:: This file is run by the appveyor builds.
::

set PYTHONPATH=tests/python/third_party

IF /I "%RUN_COVERAGE%" EQU "1" (
    coverage run tests/run_tests.py
)
ELSE (
    python tests/run_tests.py
)

:: FIXME: This approach does not scale...
if not %ERRORLEVEL% == 0 exit /b %ERRORLEVEL%

:: This suffix for appveyor is sufficient, since we never run more than one build at a time.
set SHOTGUN_TEST_ENTITY_SUFFIX=app_veyor

:: Run these tests only if the integration tests environment variables are set.
IF DEFINED SHOTGUN_HOST (
    python tests\integration_tests\run_integration_tests.py --with-coverage

) ELSE (
    ECHO "Skipping integration tests, SHOTGUN_HOST is not set."
)
