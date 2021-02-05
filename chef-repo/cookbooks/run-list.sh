for i in $(knife node list|grep node)
do
            knife node run_list set $i 'recipe[apache-tomcat]'
done

