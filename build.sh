company="omniloc"
software="docker-on-demand"
version="1.0.0"
reg_login="omniloc"
reg_pass="0OgKesAIeZEjKoQ"

docker logout
docker build -t ${company}/${software}:${version} .  | tee build.log || exit 1
ID=$(tail -1 build.log | awk '{print $3;}')

docker tag $ID ${company}/${software}:${version}

echo "Registry pass is: ${reg_pass}"
docker tag $ID tutum.co/${reg_login}/${software}:${version}
docker push tutum.co/${reg_login}/${software}:${version} 
