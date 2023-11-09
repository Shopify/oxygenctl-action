        TOKEN="${{ inputs.oxygen_deployment_token }}"
        echo "::add-mask::$TOKEN"

        if [[ "${TOKEN}" == *":"* ]]; then
          echo "Multi deployment"
          IFS=':' read -ra token_list <<< "${TOKEN}"
          v1_token=${token_list[0]}
          v2_token=${token_list[1]}
          echo "::add-mask::$v1_token"
          echo "::add-mask::$v2_token"
          echo "v1_token=$v1_token" >> $GITHUB_OUTPUT
          echo "v2_token=$v2_token" >> $GITHUB_OUTPUT

          set +e
          shop_id=$(echo "${v2_token}" | base64 -d | jq -r '.namespace')
          echo "Fetching configuration for shop $shop_id"
          hydrogen_configuration_url="${UNSAFE_HYDROGEN_CONFIGURATION_URL:-https://hydrogen-storefronts.shopifyapps.com}"
          configuration_response=$(curl -s -f "${hydrogen_configuration_url}/api/admin/configuration/shop/${shop_id}" | jq .deployment 2>/dev/null)
          set -e

          if [[ -z "$configuration_response" ]]; then
            echo "Configuration response is empty"
            echo "IS_V1=true" >> $GITHUB_ENV
            echo "PRIORITY=v1" >> $GITHUB_ENV
          else
            priority=$(echo "$configuration_response" | jq -r .priority)
            echo "PRIORITY=${priority}" >> $GITHUB_ENV
            echo "IS_V2=$(echo "$configuration_response" | jq -r .v2_enabled)" >> $GITHUB_ENV
            echo "IS_V1=$(echo "$configuration_response" | jq -r .v1_enabled)" >> $GITHUB_ENV
          fi
        else
          if [[ "${TOKEN}" =~ ^[A-Za-z0-9+/]+[=]{0,2}$ ]]; then
            echo "Token is in V2 format"
            echo "IS_V2=true" >> $GITHUB_ENV
            echo "PRIORITY=v2" >> $GITHUB_ENV
            echo "v2_token=${TOKEN}" >> $GITHUB_OUTPUT
          else
            echo "Token is in V1 format"
            echo "IS_V1=true" >> $GITHUB_ENV
            echo "PRIORITY=v1" >> $GITHUB_ENV
            echo "v1_token=${TOKEN}" >> $GITHUB_OUTPUT
          fi
        fi
