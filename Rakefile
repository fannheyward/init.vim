desc "deploy vimrc"
task :deploy do
    system 'git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle'
    system 'cp vimrc ~/.vimrc'
    system 'cp gvimrc ~/.gvimrc'
    system 'vim +BundleInstall +qa'
end
