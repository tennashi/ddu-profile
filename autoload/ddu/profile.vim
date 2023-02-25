let s:profiles = {}

function! ddu#profile#new(name) abort
  let s:profiles[a:name] = {}
endfunction

function! ddu#profile#insert_source(name, source, index) abort
  let l:cur_sources = s:profiles[a:name]['sources']
  let l:sources = insert(l:cur_sources, source, index)

  let s:profiles[a:name]['sources'] = l:sources
endfunction

function! ddu#profile#load(name) abort
  let l:profile = s:profiles[a:name]
  call ddu#custom#patch_local(a:name, l:profile)
endfunction

augroup DDUProfile
  autocmd!
  autocmd User DDUReady call s:install_profile()
augroup END

function! s:install_profile() abort
  map(s:profiles, { name, profile -> ddu#custom#patch_local(a:name, a:profile) })
endfunction
