declare
    RoomIDs SYS.ODCINUMBERLIST;
    EquipIDs SYS.ODCINUMBERLIST;
    MaintenanceStatus boolean;
begin
    -- Simulate user input for room and equipment IDs
    RoomIDs := SYS.ODCINUMBERLIST(1212); -- room IDs to put in maintenance
    EquipIDs := SYS.ODCINUMBERLIST(4800); -- equipment IDs to put in maintenance

    -- Update maintenance status
    MaintenanceStatus := UpdateMaintenanceStatus(RoomIDs, EquipIDs);

    if MaintenanceStatus then
        -- Redirect patients and staff
        RedirectOperationsAndStaff(RoomIDs, EquipIDs);
        DBMS_OUTPUT.PUT_LINE('Maintenance update and redirection completed successfully.');
    else
        DBMS_OUTPUT.PUT_LINE('Failed to update maintenance status.');
    end if;
end;
/
