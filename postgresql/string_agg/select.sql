select
    planes.name,
    string_agg(equipments.name, ',') as equipments
from planes, equipment_list, equipments
where
    equipment_list.plane_id = planes.id
    and equipment_list.equipment_id = equipments.id
group by planes.name
