" formatting
function! DoFmt()
  if executable('xmllint')
    %!xmllint --format -
  else
    echo 'Unable to format: jq and python executables cannot be found'
  endif
endfunction
