docker exec -it `docker ps | grep android-studio | awk 'BEGIN{FS=" "}{print $NF}'` bash
