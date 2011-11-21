desc "deploy vimrc"
task :deploy do
    system 'git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle'
    system 'ln -s ./vimrc ~/.vimrc'
    system 'ln -s ./gvimrc ~/.gvimrc'
    system 'vim +BundleInstall +qa'
end
