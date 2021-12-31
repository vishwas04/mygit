#!/usr/bin/python3
import os
# import Developer as dv
import psycopg2 as ps2

dbname = 'github'
dbpassword = 'vishwas123.'



# Analytics:

def validProject(c_id,p_id):
    global dbname,dbpassword
    
    cmd = 'Select * from project where P_RID=%s and P_Company_ID=%s' %(p_id,c_id)
    
    conn = ps2.connect(database = dbname,user = 'vishwas',password = dbpassword)
    cur = conn.cursor()
    
    cur.execute(cmd)
    r = cur.fetchall()
    
    cur.close()
    conn.commit()
    
    return r != []

def analytics():
    dbname = 'github'
    dbpassword = 'admin'
    dbuser='postgres'
    cid = int(input('Input Company ID: '))
    #pid = input('Input Project ID: ')
    #validCompany(cid)        
    if ~validCompany(cid) :
        print("Company Doesn't Exist!")
    else:
        print("1)  Find User who makes most versions in a project         | MostActiveUser(ProjectID)")
        print("2)  Version belonging to most branches in a project        | MostCommonVersion(ProjectID)")
        print("3)  File belonging to most versions in a project           | MostCommonFile(ProjectID)")
        #print("4)  Avg. size of a file of a specific type in the project     | AverageFileSize(ProjectID,FileType)")
        print("4)  Average salary of the Company's Employee               | AverageSalary()")
        print("5)  Total Money the company spent for a project            | ProjectExpenditure(ProjectID)")
        print("6)  Total Memory Space occupied by a project               | ProjectSize(ProjectID)")
        print("7)  Estimated cost for completing a project                | CostEstimate(ProjectID)")
        print("8)  Project requiring least time to be completed           | FastestProject()")
        print("9)  Largest Local Repo in the Database                     | LargestLocalRepo()")
        
        op = input("Input: ")
        
        if(op[0:14]=="MostActiveUser"):
            projID = (int(op.replace(")","(").split("(")[1]))
            # !!! code to check if proj. exists in Company
            if ~validProject(cid,projID) :
                print("Project Doesn't Exist or does not belong to Company!")
            else:
                code = "select sq1_main(%d);"%(projID)
                conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
                cur = conn.cursor(code)
                cur.execute(code)
                case = cur.fetchall()
                cur.close()
                conn.commit()
                print("The most Active/Contributing user to the project is User",case)
                
        
        if(op[0:17]=="MostCommonVersion"):
            projID = (int(op.replace(")","(").split("(")[1]))
            # !!! code to check if proj. exists in Company
            if ~validProject(cid,projID) :
                print("Project Doesn't Exist or does not belong to Company!")
            else:
                code = "select sq2_main(%d);"%(projID)
                conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
                cur = conn.cursor(code)
                cur.execute(code)
                case = cur.fetchall()
                cur.close()
                conn.commit()
                print("The version belonging to most branches in the project is Version",case)
        
        if(op[0:14]=="MostCommonFile"):
            projID = (int(op.replace(")","(").split("(")[1]))
            # !!! code to check if proj. exists in Company
            if ~validProject(cid,projID) :
                print("Project Doesn't Exist or does not belong to Company!")
            else:
                code = "select sq3_main(%d);"%(projID)
                conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
                cur = conn.cursor(code)
                cur.execute(code)
                case = cur.fetchall()
                cur.close()
                conn.commit()
                print("File belonging to most versions in the project is having FID",case)  
                
        if(op[0:13]=="AverageSalary"):
            #projID = (int(op.replace(")","(").split("(")[1]))
            #file_type = (int(op.replace(")","(").split("(")[1]))
            # !!! code to check if proj. exists in Company
            #if ~validProject(cid,projID) :
            #    print("Project Doesn't Exist or does not belong to Company!")
            #else:
            code = "select sq5_main(%d);"%(cid)
            conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
            cur = conn.cursor(code)
            cur.execute(code)
            case = cur.fetchall()
            cur.close()
            conn.commit()
            print("The Average Salary paid to an employee in the company %d is"%cid,case)
            
        if(op[0:18]=="ProjectExpenditure"):
            projID = (int(op.replace(")","(").split("(")[1]))
            # !!! code to check if proj. exists in Company
            if ~validProject(cid,projID) :
                print("Project Doesn't Exist or does not belong to Company!")
            else:
                code = "select q1_main(%d);"%(projID)
                conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
                cur = conn.cursor(code)
                cur.execute(code)
                case = cur.fetchall()
                cur.close()
                conn.commit()
                print("Total Money the company spent on the project is Rs.",case)                               
                
        if(op[0:11]=="ProjectSize"):
            projID = (int(op.replace(")","(").split("(")[1]))
            # !!! code to check if proj. exists in Company
            if ~validProject(cid,projID) :
                print("Project Doesn't Exist or does not belong to Company!")
            else:
                code = "select q2_main(%d);"%(projID)
                conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
                cur = conn.cursor(code)
                cur.execute(code)
                case = cur.fetchall()
                cur.close()
                conn.commit()
                print("Total Memory Space occupied by the project is ",case) 
            
        if(op[0:12]=="CostEstimate"):
            projID = (int(op.replace(")","(").split("(")[1]))
            # !!! code to check if proj. exists in Company
            if ~validProject(cid,projID) :
                print("Project Doesn't Exist or does not belong to Company!")
            else:
                code = "select q3_main(%d);"%(projID)
                conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
                cur = conn.cursor(code)
                cur.execute(code)
                case = cur.fetchall()
                cur.close()
                conn.commit()
                print("Estimated cost for completing the project is",case)  
                   
        if(op[0:14]=="FastestProject"):
            #projID = (int(op.replace(")","(").split("(")[1]))
            #file_type = (int(op.replace(")","(").split("(")[1]))
            # !!! code to check if proj. exists in Company
            #if ~validProject(cid,projID) :
            #    print("Project Doesn't Exist or does not belong to Company!")
            #else:
            code = "select q4_main(%d);"%(cid)
            conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
            cur = conn.cursor(code)
            cur.execute(code)
            case = cur.fetchall()
            cur.close()
            conn.commit()
            print("Project requiring least time to be completed in the company %d is"%cid,case) 
        
        if(op[0:14]=="LargestLocalRepo"):
            code = "select q5_main();"
            conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
            cur = conn.cursor(code)
            cur.execute(code)
            case = cur.fetchall()
            cur.close()
            conn.commit()
            print("The Largest Local Repo in the database %d is"%cid,case)                      
                                
        else:
            print("\n **Invalid Input**")

    



def validCompany(c_id):
    global dbname,dbpassword
    
    cmd = 'Select * from company where company_id = %s' %(c_id)
    
    conn = ps2.connect(database = dbname,user = 'vishwas',password = dbpassword)
    cur = conn.cursor()
    
    cur.execute(cmd)
    r = cur.fetchall()
    
    cur.close()
    conn.commit()
    
    return r != []

def validDev(dev,p_rid):
    global dbname,dbpassword
    assert type(dev) == Dev
    
    cmd = 'Select * from repository where remote_rid = %s and owns = %s' %(p_rid,dev.u_id)
    
    conn = ps2.connect(database = dbname,user = 'vishwas',password = dbpassword)
    cur = conn.cursor()
    
    cur.execute(cmd)
    r = cur.fetchall()
    
    cur.close()
    conn.commit()
    
    return r != []

def getLocalId(dev,p_rid):
    global dbname,dbpassword
    
    
    assert type(dev) == Dev
    
    cmd = 'Select rid from repository where owns = %s and remote_rid = %s' %(dev.u_id,p_rid)
    conn = ps2.connect(database = dbname,user = 'vishwas',password = dbpassword)
    cur = conn.cursor()
    
    cur.execute(cmd)
    r = cur.fetchone()[0]
    
    cur.close()
    conn.commit()
    
    return r

class File:
    def __init__(self,file_name = '',typeF = '',file_contains = '',file_size = 0,isURL = False):
        
        if isURL:
            fo = open(file_contains,'r')
            file_contains = fo.read()
        
        self.name = file_name
        self.type = typeF
        self.contains = file_contains
        self.size = file_size
def github_init(path_to_init_file):
    '''
    Input: db_name: Name of the database
           path_to_init_file: path to the sql file
           pwd: password to postgres user
    '''
    global dbname,dbpassword
    
    f = open(path_to_init_file,'r')
    cmd = f.read()
    f.close()
    conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
    cur = conn.cursor()
    cur.execute(cmd)
    cur.close()
    conn.commit()
    
    

class Dev:
   
    def __init__(self,u_id,pwd,isNew = False):
        '''
        This is a developer:
        '''
        
        if isNew: 
            u_id = self.createDev(pwd)
            print('%s is your user id' %(u_id))
        if not isNew:
            if(self.is_valid(u_id,pwd)==-1):
                self.u_id = -1
                self.pwd = -1
                print("LOGIN FAILED")

            else:                
                self.u_id = u_id
                self.pwd = pwd
    
    def is_valid(self,u_id,pwd):
        
        global dbname,dbpassword
        pwd = "'" + pwd + "'"
        
        isOldCmd = 'Select * from developer where user_id = %s and password = %s' %(u_id,pwd)
        
        conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
        cur = conn.cursor()
        
        cur.execute(isOldCmd)
        r = cur.fetchall()
        if r == []:
            return -1
            # raise ValueError('User name and password do not match')
        else:
            print("Logged with user id "+str(u_id))
        
        
        
        cur.close()
        conn.commit()
    
    def createDev(self,pwd):
        
        global dbname,dbpassword
        
        conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
        cur = conn.cursor()
        
        cur.callproc('create_developer',(pwd,))
        u_id = cur.fetchone()[0]
        
        cur.close()
        conn.commit()
        
        return u_id
    
    def addDev2Proj(self,newDev_userid,p_rid):
        '''
        self must be currently working in the project p_rid.
        If newDev is not working in the project, he/she gets a new local repo with no branches in it.
        Relations accessed:
            i) Project
            ii) Repository
        Relations which would be changed:
            i) Repository
            ii) Employs - new employee salary will be default set to 0
        '''
        global dbname,dbpassword
        
        chkInProj = '''
        select * from repository
        where remote_rid = %s and owns = %s
        ''' %(p_rid,self.u_id)
        
        getMaxId = '''
        select max(rid)
        from repository
        '''
        


        
        
        conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")


        cur = conn.cursor()
        before_exists="select * from repository where owns="+str(newDev_userid)+" and remote_rid="+str(p_rid)+";"
        cur.execute(before_exists)
        case = cur.fetchall()
        cur.close()
        conn.commit()
        if(len(case)!=0):
            print("Member already in group")
            return -1


        cur = conn.cursor()
        cur.execute(chkInProj)
        r = cur.fetchall()
        if r == []:
            raise ValueError("Permission Denied")
        
        else:
            cur.execute(getMaxId)
            
            newId = cur.fetchone()[0] + 1
        
            add2Proj = '''
            insert into repository values(%s,%s,%s,%s)
            ''' %(newId,p_rid,newDev_userid,0)
            


            cur.execute(add2Proj)
            cur.close()
            cur = conn.cursor()
            add_master_branch="INSERT INTO Branch values (1,"+str(newId)+",CURRENT_TIMESTAMP(0),null,null);"
            cur.execute(add_master_branch) 
            print("Succesfully added (added member has no salary assigned)!")
        
        cur.close()
        conn.commit()
    def my_repo(self):
        # chkInProj = '''
        # select * from repository
        # where owns = %s
        # ''' %(self.u_id)
        # conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
        # cur = conn.cursor(chkInProj)
        # cur.execute(chkInProj)
        # case = cur.fetchall()
        # cur.close()
        # conn.commit()

        proj_decs = "select * from  repository as R,project as P where r.owns ="+str(self.u_id)+ "and r.remote_rid=p.p_rid;"
        conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
        cur = conn.cursor(proj_decs)
        cur.execute(proj_decs)
        case = cur.fetchall()
        cur.close()
        conn.commit()

        return case
    

class Project:
    
    def __init__(self,dev,isNew = False,p_rid = 0,desc = '',c_id = 0):
        '''
        Input:
            dev: Developer of type Dev
            p_rid: project repo id
            desc: description
            c_id: company id
        If project not isNew, p_rid != 0, dev must be a part of the project, validity will be checked   
        
        The object will have attributes:
            i) p_rid : Remote repo id
            ii) dev : Developer object
            iii) l_rid : Local repo id
        Any project specific request like push, pull, merge, commit, branch are handled here
        '''
        
        global dbname,dbpassword
        
        assert type(dev) == Dev
        
        if isNew and (validCompany(c_id) or c_id == 0):
            self.p_rid = self.createProj(c_id,desc,dev)
            self.dev = dev
            self.l_rid = getLocalId(dev,self.p_rid)
            print('Succesfully created !')
            
        elif not (validCompany(c_id) or c_id == 0):
            raise ValueError('Company and project do not match')
        
        elif (not isNew) and validDev(dev,p_rid):
            self.p_rid = p_rid
            self.dev = dev
            self.l_rid = getLocalId(dev,p_rid)
            
        else:
            raise ValueError('Project and developer do not match')
        
    
    def createProj(self,c_id,desc,dev):
        '''Returns newly created project id'''
        
        
        global dbname,dbpassword
        
        conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
        cur = conn.cursor()
        
        cur.callproc('create_project',(c_id,desc,dev.u_id,dev.pwd))
        p_rid = cur.fetchone()[0]
        
        
        cur.close()
        conn.commit()
        
        return p_rid
    
    def pull(self):
        ''' Calls the database's pull function with required inputs'''
        
        global dbname,dbpassword
        dev = self.dev
        l_rid = self.l_rid
        
        conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
        cur = conn.cursor()
        
        cur.callproc('pull',(dev.u_id,l_rid))
        case = cur.fetchone()[0]
        
        cur.close()
        conn.commit()
        
        if case:
            print("Pull Successfull")
        else:
            print("Pull Failed")
        
    def push(self):
        
        ''' Calls the database's push function with required inputs'''
        
        global dbname,dbpassword
        dev = self.dev
        l_rid = self.l_rid
        
        conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
        cur = conn.cursor()
    
        cur.callproc('push',(dev.u_id,l_rid))
        case = cur.fetchone()[0]
        
        cur.close()
        conn.commit()
        
        if case:
            print("Push Successfull")
        else:
            print("Push Failed")
    
    
    def merge(self,m_bid1,m_bid2):
        ''' Calls the database's merge function with required inputs.
            New version is created in m_bid1 using the latest versions from m_bid1 and m_bid2'''
        
        global dbname,dbpassword
        
        l_rid = self.l_rid
        
        conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
        cur = conn.cursor()
    
        cur.callproc('merge',(m_bid2,m_bid1,l_rid))
        case = cur.fetchone()[0]
        
        cur.close()
        conn.commit()
        
        if case != -1:
            print("Merge Successful and new version num = %s" %(case))
        else:
            print("Merge Failed")
    
    
    def branch(self,p_bid):
        ''' Calls the database's create_branch function with required inputs.
            New branch is created in remote and local repos as a child of p_bid'''
        
        global dbname,dbpassword
        dev = self.dev
        l_rid = self.l_rid
        
        conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
        cur = conn.cursor()
    
        cur.callproc('create_branch',(dev.u_id,l_rid,p_bid))
        case = cur.fetchone()[0]
        
        cur.close()
        conn.commit()
        
        if case != -1:
            print("Branch Successfull and new branch num = %s" %(case))
        else:
            print("Branch Failed")
    
    def commit(self,b_id,files_list):
        '''
        Input: b_id : branch of new commit
               files_list : List of file objects which is to be added in the commit
        
        '''
        assert [i for i in files_list if type(i) == File] == files_list and files_list != []
        global dbname,dbpassword
        dev = self.dev
        l_rid = self.l_rid
        
        conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
        cur = conn.cursor()
        
        isNew = 1
        
        vid = -1
        for file in files_list:
            cur.callproc('Commit',(isNew,b_id,l_rid,file.name,file.type,file.contains,file.size))
            vid = cur.fetchone()[0]
            isNew = 0
            if vid == -1:
                break
        
        
        cur.close()
        conn.commit()
        
        if vid == -1:
            print("Commit Failed")
        else:
            print("Commit Succesful with vid:" ,vid)
    def files_with_repo_id(self):
        file_ids = '''
        select contains_fid from contains
        where contains_v_rem_repo_id = %s 
        ''' %(self.p_rid)
        conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
        cur = conn.cursor(file_ids)
        cur.execute(file_ids)
        case = cur.fetchall()
        cur.close()
        conn.commit()
        return case

    def display_branchs(self):
        file_ids = '''
        select bid from branch
        where b_rid = %s 
        ''' %(self.l_rid)
        conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
        cur = conn.cursor(file_ids)
        cur.execute(file_ids)
        case = cur.fetchall()
        cur.close()
        conn.commit()
        return case
    def myversions(self,current_branch):
        versions="select vid from holds where bid="+str(current_branch)+" and b_rid="+str(self.l_rid)
        print(versions)
        conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
        cur = conn.cursor(versions)
        cur.execute(versions)
        case = cur.fetchall()
        cur.close()
        conn.commit()
        return case
    def get_files(self,current_branch,current_commit):
        my_files="select * from contains,file where contains.contains_vid ="+str(current_commit)+" and contains.contains_fid=file.fid "
        conn = ps2.connect(database=dbname, user="vishwas", password="vishwas123.", host="127.0.0.1", port="5432")
        cur = conn.cursor(my_files)
        cur.execute(my_files)
        case = cur.fetchall()
        cur.close()
        conn.commit()
        return case



# "select * from contains,file where contains.contains_vid =7 and contains.contains_fid=file.fid and contains_v_rem_repo_id="    

def clearConsole():
    command = 'clear'
    if os.name in ('nt', 'dos'):  # If Machine is running on Windows, use cls
        command = 'cls'
    os.system(command)
new_dev=None#Dev(int(1),"password1",False)
proj = None#Project(new_dev,p_rid = 1)
current_branch=None
current_repo=None
clearConsole()
while(1):
    display="\n\n1)create dev 'password'\n2)login 'user_id' 'password'\n"
    print(display)
    q=input()
    if(q[:10]=="create dev"):
        password=q.split(" ")[2]
        clearConsole()
        new_dev = Dev(1,password,True)
    if(q[:5]=="login"):
        if(len(q.split(" "))>=3):
            user_id=q.split(" ")[1]
            password=q.split(" ")[2]
            clearConsole()
            new_dev = Dev(int(user_id),password,False)
            while(1 and  new_dev.u_id!=-1):
                inner_disp="\n1)my_projects\n2)goto_project\n3)my_branches\n4)goto_branch\n5)pull\n6)push\n7)merge 'branch_numA' 'branch_numB'\n8)commit 'path_of_folder'\n9)new_branch\n10)add_member\n11)new_project 'project desc'\n12)import_version\n13)logout\n"
                print(inner_disp)
                inner_q=input()
                if(inner_q[:6]=="logout"):
                    clearConsole()
                    new_dev=None
                    proj=None
                    current_branch=None
                    break
                if(inner_q.split(" ")[0]=="my_projects"):
                    clearConsole()
                    if(new_dev==None):
                        print("Login ples")
                    else:
                        repo_t=new_dev.my_repo()
                        # print("Your Projects",repo_t)
                        for i in repo_t:
                            print("your_local_repo_id->",i[0],"remote_repo_id->",i[1],"Project Description -> ",i[5])
                if(inner_q.split(" ")[0]=="goto_project"):
                    clearConsole()
                    if(new_dev==None):
                        print("Login ples")
                    if(len(inner_q.split(" "))>=2):
                        p_r=inner_q.split(" ")[1]
                        proj=Project(new_dev,p_rid = p_r)
                        current_repo=proj.l_rid
                        print("Now your in project ",p_r,"with local repo id ",proj.l_rid)
                    else:
                        print("Enter project id")

                if(inner_q[:4]=="pull"):
                    clearConsole()
                    if(new_dev==None):
                        print("Login ples")
                    else:
                        proj.pull()

                if(inner_q[:4]=="push"):
                    clearConsole()
                    if(new_dev==None):
                        print("Login ples")
                    else:
                        proj.push()
                if(inner_q[:5]=="merge"):
                    clearConsole()
                    branch_A=int(inner_q.split(" ")[1])
                    branch_B=int(inner_q.split(" ")[2])
                    print("Local Repo ID is",proj.l_rid)
                    proj.merge(branch_A , branch_B)
                if(inner_q.split(" ")[0]=="my_branches"): 
                    clearConsole()
                    print("Branches present are")
                    if(proj):
                        for i in proj.display_branchs():
                            print(i[0],end=" ")
                    else:
                        print("goto a project first")
                if(inner_q.split(" ")[0]=="goto_branch"):
                    current_branch=int(inner_q.split(" ")[1])
                    clearConsole()
                    print("Current branch ",current_branch)

                if(inner_q.split(" ")[0]=="commit"):
                    clearConsole()
                    if(new_dev==None):
                        print("Login ples")
                    else:
                        path=inner_q.split(" ")[1]
                        print(path)
                        dir_list = os.listdir(path)
                        files=[]
                        for i in dir_list:
                            c=i
                            i=path+i
                            f = open(i, "r")
                            fi = File(file_name=c.split(".")[0], typeF=i.split(".")[1], file_contains=f.read(), file_size=os.path.getsize(i))
                            files.append(fi)
                            f.close()
                        if(current_branch):
                            proj.commit(current_branch,files)   
                        else:
                            print("go to a branch first")  
                if(inner_q.split(" ")[0]=="add_member"):
                    clearConsole()
                    if(new_dev):
                        new_dev.addDev2Proj(int(inner_q.split(" ")[1]),proj.p_rid)
                if(inner_q.split(" ")[0]=="new_branch"):
                    clearConsole()
                    if(new_dev==None):
                        print("Login ples")
                    else:
                        if(proj==None):
                            print("goto project")
                        else:
                            proj.branch(current_branch)
                if(inner_q.split(" ")[0]=="new_project"):
                    if(len(inner_q.split(" "))>=2):
                        pro_dec=inner_q[12:]
                        print("Enter company id or -1")
                        c=int(input())
                        if(c!=-1):
                            Project(new_dev,True,desc=pro_dec,c_id=c)
                        else:
                            Project(new_dev,True,desc=pro_dec)
                
                if(inner_q.split(" ")[0]=="import_version"):
                    clearConsole()
                    if(new_dev==None):
                        print("Login ples")
                    else:
                        if(proj==None):
                            print("goto project")
                        else:
                            my_commits=[int(i[0]) for i in proj.myversions(current_branch)]
                            print("Select version to go back")
                            for i in my_commits:
                                print(i,end=" ")
                            which_to_rollback=int(input())
                            print("Path to where to rollback")
                            if(which_to_rollback in my_commits):
                                path_to_rollback=input()
                                os.mkdir(path_to_rollback)
                                os.chdir(path_to_rollback)
                                final_files=[[i[4]+"."+i[5],i[6]] for i in proj.get_files(current_branch,which_to_rollback)]
                                # print(final_files)
                                # print(proj.get_files(current_branch,which_to_rollback))
                                for j in final_files:
                                    file1 = open(j[0], 'w')
                                    file1.write(j[1])
                                    file1.close()


                            else:
                                print("commit not preseent in branch")


        else:
            print("Enter userid and password")
    
    # if(q=='company'):
    #     analytics()

