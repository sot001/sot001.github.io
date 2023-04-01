When using [awsume](https://awsu.me/) within a launcher shell script,
export the statements (via the -s switch) to a variable then execute
that to set the session

    for profile in dev uat live; do
      SETPROFILE=$(awsume -s $profile)
      $SETPROFILE
      python my-aws-script.py
    done