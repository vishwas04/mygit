\c github

ALTER TABLE Developer add CHECK (LENGTH(Password)>=8);

ALTER TABLE Employs add constraint e_fk1 FOREIGN KEY (E_user_ID) REFERENCES Developer(User_ID) on DELETE CASCADE;
ALTER TABLE Employs add constraint e_fk2 FOREIGN KEY (E_Company_ID) REFERENCES Company(Company_ID) on DELETE CASCADE;

ALTER TABLE Project add constraint p_fk1 FOREIGN KEY (P_RID) REFERENCES Repository(RID) on DELETE SET NULL;
ALTER TABLE Project add constraint p_fk2 FOREIGN KEY (P_Company_ID) REFERENCES Company(Company_ID) on DELETE CASCADE;
ALTER TABLE Project add CHECK (Progress_Bar>=0);
ALTER TABLE Project add CHECK (Progress_Bar<=100);

ALTER TABLE Repository add constraint r_fk1 FOREIGN KEY (Remote_RID) REFERENCES Project(P_RID) on delete cascade;
ALTER TABLE Repository add constraint r_fk2 FOREIGN KEY (Owns) REFERENCES Developer(User_ID) on delete set null;
ALTER TABLE Repository add CHECK (hours>=0);

ALTER TABLE Branch add constraint b_fk1 FOREIGN KEY (B_RID) REFERENCES Repository(RID);
ALTER TABLE Branch add constraint b_fk2 FOREIGN KEY (parent_BID,parent_B_RID) REFERENCES Branch(BID,B_RID);

ALTER TABLE Holds add constraint h_fk1 FOREIGN KEY (BID,B_RID) REFERENCES Branch(BID,B_RID);
ALTER TABLE Holds add constraint h_fk2 FOREIGN KEY (VID,V_rem_repo_ID) REFERENCES Version(VID,V_rem_repo_ID);

ALTER TABLE Version add constraint v_fk1 FOREIGN KEY (V_User_ID) REFERENCES Developer(User_ID) ON DELETE SET NULL;

ALTER TABLE Contains add constraint c_fk1 FOREIGN KEY (Contains_VID,Contains_V_rem_repo_ID) REFERENCES Version(VID,V_rem_repo_ID);
ALTER TABLE Contains add constraint c_fk2 FOREIGN KEY (Contains_FID) REFERENCES File(FID);

ALTER TABLE File ALTER COLUMN type SET DEFAULT '.txt'; 