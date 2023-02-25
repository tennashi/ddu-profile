let s:profiles = {}

function! ddu#custom#profile#new(name) abort
  let s:profiles[a:name] = {}
endfunction

function! ddu#custom#profile#ensure(name) abort
  if !has_key(s:profiles, a:name)
    call ddu#custom#profile#new(a:name)
  endif
endfunction

function! ddu#custom#profile#insert_source(name, source, index) abort
  if !has_key(s:profiles[a:name], 'sources')
    let s:profiles[a:name]['sources'] = []
  endif

  let l:cur_sources = s:profiles[a:name]['sources']
  let l:sources = insert(l:cur_sources, a:source, a:index)

  let s:profiles[a:name]['sources'] = l:sources
endfunction

function! ddu#custom#profile#add_source(name, source) abort
  if !has_key(s:profiles[a:name], 'sources')
    let s:profiles[a:name]['sources'] = []
  endif

  let l:cur_sources = s:profiles[a:name]['sources']
  let l:sources = add(l:cur_sources, a:source)

  let s:profiles[a:name]['sources'] = l:sources
endfunction

function! ddu#custom#profile#load(name) abort
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
