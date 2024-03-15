UPDATE 'Pet/Character'
    SET Accessories = 'scarf', Food = 'apple'
    WHERE UserID > 1;
    
SELECT
    User.Birthday,
    'Pet/Character'.Name
    FROM 'Pet/Character'
    JOIN User WHERE User.UserID = 'Pet/Character'.UserID;