message_prefix=disable_checks.sh

if [[ -z "${APP_NAME}" ]]; then
    echo "[${message_prefix}]: APP_NAME is undefined! Stopping execution of remaining flow file."
    echo "[${message_prefix}]: Run \"export APP_NAME=<app_name>\" first."
    exit 1
fi

echo "[${message_prefix}]: jq version: `jq --version`"

echo "Checking quality check exceptions for Application: ${APP_NAME}"

allowlist=$(< quality_checks_overrides/qc_overrides.json jq -r --arg appname "${APP_NAME}" '[.qualityChecksOverrides[] | select( .app_name==$appname ) | select( .start_date > (now - .time_to_live_days*24*60*60 | strftime("%Y-%m-%dT%H:%M:%SZ"))) | .policy] | join(",")')

echo "[${message_prefix}]: Allow List: \"$allowlist\". Turning off these checks from Allow List for APP_NAME=${APP_NAME}"

for i in ${allowlist//,/ }
do
    echo "[${message_prefix}]: Turn off check >> $i <<"
done
if [ -n "$allowlist" ]; then
    liquibase --show-banner=false checks bulk-set --check-name=$allowlist --severity=0 --force --checks-settings-file=quality_checks/liquibase.checks-settings.conf
fi



# liquibase --show-banner=false checks bulk-set --check-name=$allowlist --severity=0 --force --checks-settings-file=quality_checks/liquibase.checks-settings.conf

# for i in ${allowlist//,/ }
# do
#   echo "  Turn off check >> $i <<"
#   # liquibase checks disable --check-name=$i --checks-settings-file=quality_checks/liquibase.checks-settings.conf
#   liquibase --show-banner=false checks bulk-set --check-name=$i --severity=4 --force --checks-settings-file=quality_checks/liquibase.checks-settings.conf
# done