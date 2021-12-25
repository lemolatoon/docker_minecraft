export GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa_git"
DATE=`TZ='Asia/Tokyo' date`

cd world
git add *
git commit -m "$DATE"
git push git@github.com:temporaryP/world.git master
cd ..

cd world_nether
git add *
git commit -m "$DATE"
git push git@github.com:temporaryP/world_nether.git master
cd ..

cd world_the_end
git add *
git commit -m "$DATE"
git push git@github.com:temporaryP/world_the_end.git master
cd ..
