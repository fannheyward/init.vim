desc "deploy vimrc"
task :deploy do
    system 'git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle'
    system 'ln -s ./vimrc ~/.vimrc'
    system 'vim +BundleInstall +qa'
end
