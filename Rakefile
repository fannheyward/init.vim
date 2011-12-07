desc "deploy vimrc"
task :deploy do
    system 'git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle'
    system 'cp vimrc ~/.vimrc'
    system 'cp gvimrc ~/.gvimrc'
    system 'vim +BundleInstall +qa'
    system 'cd ~/.vim/bundle/Command-T/ruby/command-t/; rvm system do ruby extconf.rb; make; cd -'
end
