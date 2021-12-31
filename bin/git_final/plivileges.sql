\c github;

CREATE USER Company_User;
CREATE USER Developer_User;
CREATE USER Viewer;

---# Company_User permissions#

GRANT SELECT ON ALL TABLES IN SCHEMA public TO Company_User;
REVOKE SELECT (Password) ON Developer FROM Company_User;
GRANT INSERT ON Project,Employs,Repository  TO Company_User;
GRANT UPDATE (Company_Description,Location) ON company TO Company_User;
GRANT UPDATE (Description,progress_bar) ON project TO Company_User;
GRANT UPDATE (salary) ON employs TO Company_User;
GRANT DELETE ON Project, Employs,Repository TO Company_User;

---# Developer_User permissions#
GRANT SELECT ON ALL TABLES IN SCHEMA public TO Developer_User;
GRANT INSERT,UPDATE ON Repository,Branch,Holds,Version,Contains,File TO Developer_User;
GRANT DELETE ON Repository,Branch,Holds,Version,Contains,File TO Developer_User;


GRANT SELECT ON ALL TABLES IN SCHEMA public TO Viewer;
REVOKE SELECT (Password) ON Developer FROM Viewer;
REVOKE SELECT (file_contains) ON File FROM Viewer;

--- # Company,Developer,Employs,Repository,Branch,Holds,Version,Contains,File #