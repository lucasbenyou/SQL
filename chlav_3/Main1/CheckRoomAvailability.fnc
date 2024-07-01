CREATE OR REPLACE FUNCTION CheckRoomAvailability(
    p_room_id IN INT
) RETURN BOOLEAN IS
    v_available VARCHAR2(10);
BEGIN
    -- Check if the room is available
    SELECT Availability INTO v_available
    FROM Operating_Room
    WHERE Room_ID = p_room_id;

    -- If no room found, return false
    IF SQL%NOTFOUND THEN
        RETURN FALSE;
    END IF;

    -- If room is already booked, return false
    IF v_available <> 'Yes' THEN
        RETURN FALSE;
    END IF;

    -- Attempt to book the room
    BEGIN
        UPDATE Operating_Room
        SET Availability = 'BOOKED'
        WHERE Room_ID = p_room_id
          AND Availability = 'Yes'
          AND ROWNUM = 1; -- ROWNUM condition for single row update

        IF SQL%ROWCOUNT = 1 THEN
            RETURN TRUE; -- Room successfully booked
        ELSE
            RETURN FALSE; -- Room could not be booked (probably already booked)
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE; -- No room found with given ID
        WHEN OTHERS THEN
            RETURN FALSE; -- Other unexpected errors
    END;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE; -- No room found with given ID
    WHEN OTHERS THEN
        RETURN FALSE; -- Other unexpected errors
END CheckRoomAvailability;
/
