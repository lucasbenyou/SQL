ALTER TABLE Operating_Room
MODIFY Availability DEFAULT 'available';

-- Insert statement to test the default value
INSERT INTO Operating_Room (Room_ID, Max_number_people)
VALUES (1274, 4);

-- Select statement to verify the default value
SELECT Room_ID, Availability
FROM Operating_Room
WHERE Room_ID = 1274;
