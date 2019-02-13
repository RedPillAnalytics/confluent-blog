
-- number of events per minute
CREATE table events_per_min AS 
SELECT userid, count(*) AS events 
FROM clickstream window TUMBLING (size 60 second) 
GROUP BY userid;

-- BUILD PAGE_VIEWS
CREATE TABLE pages_per_min AS 
SELECT userid, count(*) AS pages 
FROM clickstream WINDOW HOPPING (size 60 second, advance by 5 second) 
WHERE request like '%html%' 
GROUP BY userid;

--Join using a STREAM
CREATE STREAM ENRICHED_ERROR_CODES AS SELECT code, definition 
FROM clickstream 
LEFT JOIN clickstream_codes 
ON clickstream.status = clickstream_codes.code;
