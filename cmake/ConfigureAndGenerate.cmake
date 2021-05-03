cmake_minimum_required(VERSION 3.0.0 FATAL_ERROR)

function(configure_and_generate)
    set(options AT_ONLY)
    set(oneValueArgs INPUT OUTPUT)
    set(multiValueArgs)
    cmake_parse_arguments(PARSE_ARGV 0 CAG "${options}" "${oneValueArgs}" "${multiValueArgs}")
    
    if(DEFINED CAG_KEYWORDS_MISSING_VALUES)
        message(FATAL_ERROR "configure_and_generate missing keywords ${CAG_KEYWORDS_MISSING_VALUES}")
    endif()

    file(
        READ "${CAG_INPUT}"
        _tmp_in
    )

    if(CAG_AT_ONLY)
        string(
            CONFIGURE "${_tmp_in}" _tmp
            @ONLY
        )
    else()
        string(
            CONFIGURE "${_tmp_in}" _tmp
        )
    endif()

    file(
        GENERATE
        OUTPUT "${CAG_OUTPUT}"
        CONTENT "${_tmp}"
    )
endfunction()
