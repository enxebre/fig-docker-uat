# = Class: behat_environment
#
# Creates an environment ready for running behat tests.
# This module has dependencies on selenium, display and java_openjdk.
#
class uat_environment {
  include uat_environment::firefox
  include uat_environment::selenium
}

