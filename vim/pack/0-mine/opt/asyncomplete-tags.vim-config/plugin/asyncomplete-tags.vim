" completion source: asyncomplete-tags.vim
"au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
"    \ 'name': 'tags',
"    \ 'whitelist': ['c', 'cpp', 'python', 'rust'],
"    \ 'priority': 0,
"    \ 'completor': function('asyncomplete#sources#tags#completor'),
"    \ 'config': {
"    \    'max_file_size': 50000000,
"    \  },
"    \ }))

