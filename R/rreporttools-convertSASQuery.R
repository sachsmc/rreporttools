#' Retrieve a sas file and extract all SQL queries from it. 
#'
#' This function takes sas code, extracts all the SQL queries and then optionally pulls them from IMPAC II. If the query is not sent to the database, it will return the extracted statements as a list of strings for editing or inspection. 
#'
#' @param sasFile Path to the sas code file. 
#' @param user Character string containing username
#' @param pass Character string containing password
#' @param submit Logical, pull the data
#' @param env If submit is TRUE, environment in which to load the data. Don't modify this unless you know what you are doing
#' @param connStr Connection string to database
#' @param pathToOJ Path to the oracle database driver. Depends on your machine, search for ojdbc6.jar from the Windows start menu. 
#' @keywords database, sql, sas, string conversion
#' @export
#' 
#'  

convertSASQuery <- function(sasFile, user, pass, submit = TRUE, 
                            env = .GlobalEnv, connStr = stop("Needs connection string"),
                            pathToOJ="C:/app/OITDSKADM/product/11.2.0/client_1/jdbc/lib/ojdbc6.jar"){
  
    
  inSasa <- readLines(sasFile)
  ## get rid of comments
  
  inSas <- gsub("[*].[^f][^r].*","", inSasa)
  
  sqlStart <- grep("connect to oracle as db", inSas, ignore.case = TRUE)
  
  if(length(sqlStart) > 0){
  
  queries <- lapply(sqlStart, function(j) parseProcSQL(inSas, j))
  
  } else {
    
  libdef <- grep("libname [[:alnum:]]+ oracle", inSas, ignore.case = TRUE)[1]
  libstate <- unlist(strsplit(inSas[libdef], " "))
  oraname <- paste0(libstate[grep("libname", libstate)+1], ".")
  
  sqlStart <- grep("proc sql", inSas, ignore.case = TRUE)[1]
  queries <- parseProcSQL.withLib(inSas, sqlStart, oraname)
  
  }
  
  drv <- JDBC("oracle.jdbc.OracleDriver", pathToOJ,  "'")
  conn <- dbConnect(drv, connStr, user, pass)
  
  if(!submit){ 
    dbDisconnect(conn)
    return(lapply(queries, function(q){
    exp <- paste(q[1], paste("mydbGetQuery(conn, '", q[2], "')"), sep = "<-")
    })) }

  if(submit){
    for(i in 1:length(queries)){
      q <- queries[[i]]
      env[[q[1]]] <- mydbGetQuery(conn, q[2])
      
    }
    tmp <- dbDisconnect(conn)
    return(unlist(lapply(queries, function(q) q[1])))
    }
  
}



#' Parses a SQL statement embedded in sas code
#' 
#' @keywords internal
#' @noRd

parseProcSQL <- function(string, sqlStart = 1){
  
  dfName <- NULL
  query <- NULL
  line <- sqlStart+1
  while(TRUE){
    if(length(grep("create table", string[line], ignore.case = TRUE))==1){
      dfName <- c(dfName, gsub(" as", "", gsub("create table ", "", string[line], 
                                     ignore.case = TRUE), ignore.case = TRUE))
          
    }
    if(length(grep("from connection to db", string[line], 
            ignore.case=TRUE))==1){
          templine <- line + 1
          tempquery <- NULL
        while(length(grep(";", string[templine], fixed = TRUE))!=1){
          tempquery <- paste(tempquery, string[templine], sep = " ")
          templine <- templine+1
          }
          tempquery<- paste(tempquery, gsub(";", "", string[templine], fixed = TRUE), sep = "")
          query <- c(tempquery)
    }
    
    if(length(grep("disconnect from db", string[line], ignore.case = TRUE))==1){ break }
    if(length(grep("quit", string[line], ignore.case = TRUE))==1){ break }
    line <- line+1
  }
  
  query <- gsub("\n", " ", gsub("\t", " ", query, fixed= TRUE), fixed = TRUE)
  return(c(dfName, query))
  
}

#' Parses a SQL statement embedded in sas code
#' 
#' @keywords internal
#' @noRd


parseProcSQL.withLib <- function(string, sqlStart = 1, oraname = "irdb."){
  
  dfname <- NULL
  query <- NULL
  line <- sqlStart + 1
  while(TRUE){
    if(length(grep("create table", string[line], ignore.case = TRUE))==1){
      dftmp <- gsub("[[:punct:]]*", "", gsub(" as", "", gsub("create table ", "", string[line], ignore.case = TRUE), ignore.case = TRUE)) 
      line <- line+1
      
      qtmp <- ""
      while(TRUE){
        if(length(grep(";", string[line], fixed = TRUE))==1){ qtmp <- paste(qtmp,
        gsub(";", "", string[line], fixed = TRUE))
        break 
        }
        qtmp <- paste(qtmp, string[line])
        line <- line+1
        }
    if(length(grep(paste("from", oraname), qtmp, ignore.case = TRUE))==0){ next 
    } else{
      qtmp <- gsub(oraname, "", qtmp, fixed = TRUE)
      dfname <- c(dfname, dftmp)
      query <- c(query, qtmp)
    }
      
    }
  line <- line+1
  if(length(grep("quit", string[line], ignore.case = TRUE)) == 1) break
    
  }
  
  query <- gsub("\n", " ", gsub("\t", " ", query, fixed= TRUE), fixed = TRUE)
  
  return(lapply(1:length(query), function(i) c(dfname[i], query[i])))
  
  }
