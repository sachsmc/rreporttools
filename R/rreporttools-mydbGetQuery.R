#' Retrieve a table from a JDBC connection and return a data.table or data.frame
#'
#' This function extends \link{dbGetQuery} by setting the column names to lower case, and optionally returning the result as an indexed data.table. This is extremely useful for large queries. 
#'
#' @param conn Connection object to database. See \link{dbConnect}
#' @param statement Character string containing SQL statement. Do not end with a semicolon
#' @param data.table Logical, return resulting object as a \link{data.table}. 
#' @param key Character string indicating which variable to use as the index. Ignored if data.table = FALSE. 
#' @param ... expressions passed to dbSendQuery()
#' @keywords database, sql, JDBC
#' @export
#' @examples
#' #mydbGetQuery(conn, "select * from all_tables", TRUE, "owner")
#' 
#'  
mydbGetQuery <- function (conn, statement, data.table = TRUE, key = NULL, ...) 
{

  string <- gsub("[ ]+", " ", gsub("\t", " ", gsub("\n", " ", statement)))

    r <- dbSendQuery(conn, string, ...)
    
    if(data.table) { temp <- data.table(fetch(r, -1))
    setnames(temp, colnames(temp), tolower(colnames(temp)))
    if (!is.null(key)) {
        setkeyv(temp, key)
    }
    } else{ temp <- fetch(r, -1) 
            colnames(temp) <- tolower(colnames(temp))
    }
    dbClearResult(r)
    return(temp)
}
