function brewcheck
    set_color --bold cyan
    echo "󰀻 Homebrew Updates"
    set_color normal
    echo ""

    brew outdated --json=v2 | jq -r '
        # 显示版本
        def ver:
            if type == "array" then join(", ")
            else (. // "-" | tostring)
            end;

        # 获取已安装的版本
        def installed:
            if type == "array" then (.[-1] // "")
            else (. // "" | tostring)
            end;

        # 解析版本号
        def parts:
            (try (
                capture("^[vV]?(?<major>[0-9]+)[.](?<minor>[0-9]+)(?:[.](?<patch>[0-9]+))?(?:[^0-9.]|$)") |
                [
                    (.major | tonumber),
                    (.minor | tonumber),
                    (.patch // "0" | tonumber)
                ]
            ) catch null) // null;
        # 比较版本差异
        def level($old; $new):
            ($old | parts) as $a |
            ($new | parts) as $b |
            if $a == null or $b == null then "OTHER"
            elif $a[0] != $b[0] then "MAJOR"
            elif $a[1] != $b[1] then "MINOR"
            elif $a[2] != $b[2] then "PATCH"
            else "OTHER"
            end;

        (
            ["TYPE", "PACKAGE", "INSTALLED", "LATEST", "LEVEL"],

            ([
                .formulae[] |
                [
                    "CLI",
                    .name,
                    (.installed_versions | ver),
                    .current_version,
                    level((.installed_versions | installed); .current_version)
                ]
            ] + [

                .casks[] |
                [
                    "APP",
                    .name,
                    (.installed_versions | ver),
                    .current_version,
                    level((.installed_versions | installed); .current_version)
                ]
            ] | sort_by(
                .[4] as $level |
                {MAJOR: 0, MINOR: 1, PATCH: 2, OTHER: 3}[$level // "OTHER"] // 3
            ) | .[])
        ) | @tsv
    ' | column -t -s (printf '\t') | awk '
        NR == 1 {
            print "\033[1;36m" $0 "\033[0m"
            next
        }
        {
            # 软件类型
            if ($1 == "CLI")
                sub(/^CLI/, "\033[32mCLI\033[0m")
            else if ($1 == "APP")
                sub(/^APP/, "\033[35mAPP\033[0m")

            # 更新级别
            if ($NF == "MAJOR")
                sub(/MAJOR$/, "\033[1;31mMAJOR\033[0m")
            else if ($NF == "MINOR")
                sub(/MINOR$/, "\033[1;33mMINOR\033[0m")
            else if ($NF == "PATCH")
                sub(/PATCH$/, "\033[1;32mPATCH\033[0m")
            else if ($NF == "OTHER")
                sub(/OTHER$/, "\033[90mOTHER\033[0m")

            print
        }
    '
end
