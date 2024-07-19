-- working w the above data:
-- Find the 5 oldest users:
SELECT * FROM Users
	ORDER BY created_at 
    LIMIT 5;

-- What day of the week do most users register on?
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM Users
GROUP BY day
ORDER BY total DESC
LIMIT 2;

-- Find the users who have never posted a photo:
SELECT username FROM Users
	LEFT JOIN Photos
    ON Users.id = Photos.user_id
WHERE image_url IS NULL;

-- Find the user with the most liked photo:
SELECT
	username,
	Photos.id,
    Photos.image_url,
    COUNT(*) AS total
FROM Photos
	JOIN Likes
		ON Likes.photo_id = Photos.id
	JOIN Users
		ON Users.id = Photos.user_id
GROUP BY Photos.id
ORDER BY total DESC
LIMIT 1;

-- How many times does the avg user post?
-- # photos / # users
SELECT ((SELECT COUNT(*) FROM Photos) / (SELECT COUNT(*) FROM Users));

-- What are the top 5 most commonly used hashtags?
SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5; 

-- Find users who have liked every single photo on the site:
SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) 
                    FROM   photos); 
