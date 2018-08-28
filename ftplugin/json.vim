" formatting
function! DoFmt()
  if executable('jq')
    %!jq .
  elseif executable('python')
    %!python -m json.tool
    %s/\s\s/ /g " replace indent, 4 spaces -> 2 spaces
  else
    echo 'Unable to format: jq and python executables cannot be found'
  endif
endfunction
