-- ex28_oracle_cloud.sql

/*

    오라클 클라우드 서비스
    - Oracle Cloud Free Tier
    - VM(Virtual Machine) > 2대까지 > 나중에 웹 수업 > 프로젝트 운영 or 포트폴리오(웹)
    - OracleAutonomous Database 2개 > 11g > 19c
    
    - 무료 서비스 > 1인 사용 적당
    - 프로젝트 > N인 사용 부족..
    
    
    - putty or MobaXterm
    
    
    가상 서버
    - 운영 체제 > Ubuntu 20.04 LTS
    - 접속 계정 > "ubuntu" + "" > 아이디 + 암호(없음)
    
    
    
    pwd
    - Print working directory
    - 현재 작업중인 폴더의 경로
    ex) /home/ubuntu/ > ubuntu 계정의 홈디렉토리
    
    
    ls <옵션> <디렉토리>
    - List Directory Contents
    - '-a' : all. 모든 파일과 디렉토리를 다 출력해라.(숨긴 파일/디렉토리)
    - '-l' : long. 정보를 상세하게..
    ex) ls -a -l
    ex) ls -al
    ex) ls -la
    ex) ls [디렉토리명] : 해당 디렉토리 아래의 디렉토리를 이동하지 않고 볼 수 있다.
    
    
    
    clear
    - Clear Screen
    
    
    방향키(위,아래)
    - 여태 실행했던 명령어의 이력 탐색
    
    
    man <명령어>
    - User's Manual

    
    cd
    - change directory
    ex) cd ..
    ex) cd 자식폴더
    ex) cd / : /로 이동
    ex) cd ~ : 홈디렉토리로 이동
    ex) cd - : 이전 디렉토리로 이동
    ex) cd : 홈드렉토리로 이동
    ex) cd /u(tab키) : u로 시작하는 디렉토리명 자동완성 
                        > u로 시작하는 이름이 여러개면 자동완성이 아니라 u로 시작하는 디렉토리를 보여줌
    
    
    
    
    
    Prompt
    > 계정명@서버이름:현재폴더$
    
    홈디렉토리(~)
    > ubuntu@ubuntu:~$
    
    
    ubuntu@ubuntu:/home$
    
    
    free
    - 메모리를 상태를 출력한다.
    
    
    date
    - 현재 시각 출력
    
    
    
    
    
    
---------------------------------------------------------------------------------------------------------------------------
    
    
    쉘
    1. bash > 수업에서 쓰는거
    2. zsh > 맥에서 쓰는거
    
    
    Swap
    - 메모리의 부족을 보완하기 위해서 > 하드디스크의 일부를 메모리처럼 사용하게 해준다.
    
    1. $ sudo fallocate -l 4G /swapfile
    2. $ sudo chmod 600 /swapfile
    3. $ sudo mkswap /swapfile
    4. $ sudo swapon /swapfile
    5. $ free
    6. 위 설정을 서버 재시작할 때도 유지
        - /etc/fstab 파일
    
            
        
    파일 열기 > 보기 or 편집
    1. cat <파일>
        - 파일의 내용을 보여준다.
        - 읽기
        - $ cat /etc/fstab
    
    
    2. vi, vim, nano
    
    
    루트 사용자 > root > 모든 권한을 가진자
    현재 로그인 계정 > ubuntu > 일반 사용자
    
    
    현재 시각 설정하기
    1. $ sudo dpkg-reconfigure tzdata
    2. Asia
    3. Seoul
    4. $ date
    


------------------------------------------------------------------------------------------
    
    리눅스에서 패키지(프로그램) 설치하기
    - apt
    - apt-get
    
    1. $ sudo apt-get update //현재 시스템의 패키지 상태를 최신 버전으로 업데이트
    2. $ sudo apt-get install nginx
    
    3. $ sudo systemctl status nginx //현재 패키지의 상태를 보여준다. > active(running)
    4. $ sudo systemctl stop nginx //실행중인 패키지를 중단한다.
    5. $ sudo systemctl start nginx //패키지를 실행한다.
    
    6. $ sudo systemctl enable nginx //서버 시작시 같이 실행된다.
    7. $ sudo systemctl disable nginx //자동 시작 중지
    
    
    
    http://www.naver.com:80         > http는 80번 포트
    https://www.naver.com:443       > https는 443번 포트
    
    
    오라클 클라우드에서 방화벽 열기
    - 네트워킹 > 가상 클라우드 네트워크 > vcn-20220504-0922 > 보안 목록 세부정보 
        > 수신 규칙 > 수신 규칙 추가 > (0.0.0.0/0   80 | 0.0.0.0/0   443) 추가
    
    
    우분투에서 방화벽 열기
    - $ sudo iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT
    - $ sudo iptables -I INPUT 1 -p tcp --dport 443 -j ACCEPT
    
    
    브라우저 주소창 > 144.24.93.54
    
    
    파일 호스트 간에 전송 > FTP > SFTP
    
    Nginx 기본 홈 디렉토리 > /var/www/html
    
    
    권한 부여(SFTP에서 작성한 html을 옮기려면(쓰려면) 권한을 줘야함)
    - $ sudo chmod -R 777 /var/www/html
    
    





*/






























































