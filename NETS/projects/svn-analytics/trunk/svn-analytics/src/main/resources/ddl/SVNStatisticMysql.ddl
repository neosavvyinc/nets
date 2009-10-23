  DROP TABLE SVN_STATISTIC;

  CREATE TABLE SVN_STATISTIC
  (
  ID INT NOT NULL AUTO_INCREMENT
  ,AUTHOR VARCHAR(100)
  ,REVISION INT NOT NULL
  ,SVN_REPOSITORY_URL VARCHAR(700) NOT NULL
  ,REV_DATE TIMESTAMP NOT NULL
  ,MESSAGE TEXT
  ,NUM_FILES_IN_REV INT
  ,NUM_FILES_ADDED_IN_REV INT
  ,NUM_FILES_DELETED_IN_REV INT
  ,NUM_FILES_MODIFIED_IN_REV INT
  ,VALID_COMMENT INT
  ,INVALID_COMMENT INT
  ,PRIMARY KEY (ID)
  );

  DROP TABLE SVN_REPOSITORY;
  CREATE TABLE SVN_REPOSITORY
  (
  ID INT NOT NULL AUTO_INCREMENT
  ,NAME VARCHAR(255) NOT NULL
  ,URL VARCHAR(700) NOT NULL
  ,USERNAME VARCHAR(1024) NOT NULL
  ,PASSWORD VARCHAR(1024) NOT NULL
  ,START_REV INT
  ,END_REV INT
  ,PRIMARY KEY (ID)
  ,UNIQUE (URL)
  ,PARENT_DIR VARCHAR(1024)
  );

  DROP TABLE SVN_FILE_SYSTEM_STATISTIC;
  CREATE TABLE SVN_FILE_SYSTEM_STATISTIC
  (
      ID INT NOT NULL AUTO_INCREMENT
      ,REPOSITORY_ID INT NOT NULL
      ,REVISION INT NOT NULL
      ,REVISION_DATE DATE NOT NULL
      ,LAST_CHANGED_REVISION INT NOT NULL
      ,AUTHOR VARCHAR(1024)
      ,RELATIVE_PATH VARCHAR(4000)
      ,PARENT_DIRECTORY VARCHAR(4000)
      ,NUMBER_OF_LINES INT
      ,FILE_NAME VARCHAR(4000)
      ,FILE_TYPE VARCHAR(1)
      ,PRIMARY KEY (ID)
  );