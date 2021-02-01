source whatreallyhappened.bash

x=1

wrh_open out.txt
wrh_push push1 test x=${x:?}
wrh_log log1 value1
wrh_save -n foobar
printf $'foobar = %s\n' "$foobar"
wrh_pop pop1 space

wrh_load $foobar
wrh_push push2
wrh_log log2 value2
wrh_pop pop2
