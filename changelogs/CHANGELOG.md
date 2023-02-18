## 6.14.4


### Added (1 change)

- clean all data. !569

## 6.14.2

### Fixed (1 change)

- fix testing-tools delete vehicles again ;)


## 6.14.1

### Fixed (1 change)

- fix testing-tools delete vehicles


## 6.14.0
Use algo 3.8.0


## 6.13.1

### Fixed (1 change)

- don't delete vehicle on deleted lane when force reload.


## 6.13.0
Use algo 3.7.0

### Fixed (1 change)

- delete StaticLocation attached to lanes.


### Changed (1 change)

- don't send lane created / udpated / deleted event at reload.


### Added (2 changes)

- integrate algo penalize in_progress parkingio.
- restore FMS mock.

## 6.12.1


### Fixed (1 change)

- Update parkingIO status to IN_PROGRESS only if an associated restitution or storage order starts.

## 6.12.0


### Added (1 change)

- Add retrieveIO

## 6.11.0
Use algo 3.6.1

### Changed (1 change)

- standardize way to retrieve vehicles on parking.

## 6.10.2


### Fixed (1 change)

- Fix onParking filter on vehicle search

## 6.10.1


### Added (1 change)

- Add back the endpoint forceExecutionDate on SopTools.

## 6.10.0
Use algo 3.5.0

### Added (3 changes)

- handle string value for boolean in vehicle search.
- Remove endpoint ForceExecutionDate from SopToolsController.
- Throw error in retrieveIO when a specified vehicle is already in another ongoing restitution/out of parking.


### Changed (1 change)

- Refacto orders: add an OrderManager who handles transactions between listener/orderEngine and OrderService.

## 6.9.5
Use algo 3.4.4

### Fixed (2 changes)

- Clean processAirlockRetrieved function in AirlockManager.
- Fix airlock unassignment when parkingIO is DONE and has several airlocks assignment to remove.

## 6.9.4


### Changed (1 change)

- Use algo 3.4.3.

## 6.9.3


### Added (1 change)

- Add distinct on lane.vehicles.

## 6.9.2
Use algo 3.4.2

### Fixed (3 changes)

- Clean transactional behavior linked to locations and moveVehicle.
- start correctly restitution of destination airlock after an order between two handover area starts.
- Stop updating physical location when vehicle is in movement (temporary fix).


### Added (2 changes)

- Donc cancel an already canceled order from the algorithm (through OrderEngine).
- Integration of algo 3.5 - add order dependencies in OrderInterface.

## 6.9.1
Use algo 3.4.1

### Added (2 changes)

- Add a try catch around priority updates.
- Throw exception during getAirlocksForDeposit step if the parkingIO is DONE or DANCELED.


### Fixed (3 changes)

- Don't rollback a canceled (resp. failed) order after receiving an event for failed (resp. canceled) order.
- Fix force reload.
- Fix NPE in airlock occupancy computation.

## 6.9.0
Use algo 3.4.0

### Added (1 change)

- support movement vehicle.

## 6.8.1


### fixed (1 changes)

- fix vehicle event with good outDate

## 6.8.0


### Added (3 changes)

- Add details on occupation of each area on parking statistics.
- Use physical location for capacity computation (for statistics and athena).
- Add event on parkingio update.

## 6.7.0


### Added (1 change)

- Expose lane available sides.

## 6.6.1


### Fixed (1 change)

- liquibase fix.

## 6.6.0

### Added (1 change)

- annotation for vehicle


## 6.5.0


### Fixed (1 change)

- reload parking width.

## 6.4.2


### Removed (1 change)

- Fix missing transactional

## 6.4.1


### Removed (1 change)

- Remove algo calls after creation or update of a parkingIO.

## 6.4.0
Use algo 3.2.0

### Added (1 change)

- Listen to order flag is_car_in_movement.

## 6.3.0


### Added (3 changes)

- Call algo to search for restitution after creating or updating a booking with a date in the retrieval.search-time-window (algo config).
- Cancel orders returned by fms synchronously when themis calls fms for cancellation.
- Lane width.


### Changed (1 change)

- Use fms client and dto from sr-commons.

## 6.2.0
Use algo 3.1.0

### Removed (1 change)

- clean legacy DB columns.


### Added (4 changes)

- Read config and add tests to allow (or forbid) overlaps between vehicles during deposit.
- Send telemetry when receiving new dimensions associated with an order.
- Standard search: implement filter operation.
- use vehicles.default-dimensions property.


### Fixed (1 change)

- update dimension on locations.

## 6.1.0


### Added (6 changes)

- Add new column ended_at to parkingIO table.
- Add SopTools endpoint to update lane properties.
- Add support for IN and NOT_EQUALS filter operation in order search.
- Complete data models for statistics: add area name of origin/dest of order, list of IOs of a vehicle and parkingIO of order.
- New SopTool endpoint to force parkingIO status.
- Send new telemetry event for parkingIO status update.


### Fixed (1 change)

- Call housekeeping after unassignement of airlock when moving to state NOT_ASSIGNED.


### Changed (1 change)

- Update OrderEngine and ParkingEngine to let the algo use only ids and not entities.

## 6.0.6


### Fixed (1 change)

- Log stack exception.

## 6.0.4


### Fixed (1 change)

- Do not drop uuid extension.

## 6.0.3


### Fixed (2 changes)

- order creation on deposit.
- clean all vehicles

## 6.0.2


### Fixed (1 change)

- fix cancel order. !487

## 6.0.1


### Fixed (1 change)

- Problem chained order location. !486

## 6.0.0


### Added (2 changes)

- Add POST /orders/search endpoint for standardized orders search.
- Vehicle location support.

## 5.31.2


### Fixed (1 change)

- Don't count canceled parking IO as ongoing when checking if a parkingIO can start on a vehicle.

## 5.31.1


### Changed (1 change)

- Use algo 2.30.1.

## 5.31.0


### Added (5 changes)

- Add parking io UUID in Order DTO.
- Cancel orders and call cerberus to cancel restitution on assigned airlocks after canceling a parking IO.
- Implement new functions to get descendants or ascendants of an order (used in algorithm).
- Move parking IO to status CANCELED when receiving an event parkingIOCanceled.
- Run housekeeping if an airlock goes to state NOT_ASSIGNED or STORAGE_ONGOING.

## 5.30.0


### Added (2 changes)

- avoid restitution and deposit on pickup airlock.
- Remove assignment of parkingIO if an empty airlock goes to NOT_ASSIGNED.

## 5.29.2


### Removed (1 change)

- Remove model update messages after deleting a vehicle / order / parkingIO.

## 5.29.1


### Added (1 change)

- Update model messgaes for stats when a vehicle / order / parkingIO is deleted.

## 5.29.0


### Added (2 changes)

- Add status to themis order model for stats.
- Use JPA methods for sorting/pagination in vehicle search endpoint.

## 5.28.2


### Changed (1 change)

- Use algo 2.27.1.

## 5.28.1

### Changed (1 change)

- Add change of 5.27.4: Fix data loading when lane from airlock is moved to new area.


## 5.28.0
Use algo 2.27.0

### Changed (1 change)

- Modify telemetry-complete-parking-stat to have more complete coumound stats.


### Removed (1 change)

- Remove cabin, parking and order statistics.


## 5.27.4


### Fixed (1 change)

- Fix data loading when lane from airlock is moved to new area.

## 5.27.3


### Fixed (1 change)

- Send vehicle left event when deleting vehicle (processing one by one)


## 5.27.2


### Fixed (1 change)

- Send vehicle left event when deleting vehicle


## 5.27.1


### Added (1 change)

- Send telemetry event for Vehicle, Order and ParkingIO data.

## 5.27.0
Use algo 2.26.0

### Added (1 change)

- Add POST /vehicles/search endpoint.


### Changed (2 changes)

- Make onParking parameter nullable to let fetch all vehicles without filters.
- do not load airlocks without lanes. !461

## 5.26.1


### Added (1 change)

- Use algo 2.25.1.

## 5.26.0


### Added (3 changes)

- Add new pickupSide column to airlock table.
- Add possibility to update vehicle vin.
- Add requested / assigned areas and airlocks to parking io DTO.

## 5.25.0


### Changed (1 change)

- End all airlocks assignment after a parkingIO OUT goes to status DONE.
- Add POST /vehicles and PUT /vehicle/uuid endpoints.


### Fixed (1 change)

- Save number plate at parking io creation/update.

## 5.24.3


### Changed (1 change)

- Use algo 2.24.3

## 5.24.2


### Fixed (1 change)

- Fix getUndoneOrdersOnLaneSide (used to compute order dependencies).

## 5.24.1
- Use algo 2.24.2.
- revert "Add POST /vehicles and PUT /vehicle/uuid endpoints."

## 5.24.0
Use algo 2.24.0


### Added (2 changes)

- Add POST /vehicles and PUT /vehicle/uuid endpoints.
- Dont go to parkingIO status RETRIEVAL if it is not in status IN_HANDOVER_AREA (ie all vehicles are in handover).


### Changed (2 changes)

- Update ManualOrderRequest to use lane name.
- refacto capacity. !438

## 5.23.1


### Fixed (1 change)

- Fix vehicle width and length in projection


## 5.23.0


### Added (1 change)

- Dont go to parkingIO status RETRIEVAL if it is not in status IN_HANDOVER_AREA (ie all vehicles are in handover).


### Changed (1 change)

- refacto capacity. !438


## 5.22.10


### Fixed (1 change)

- Fix vehicle width and length in projection


## 5.22.9


### Added (1 change)

- don't update shape if there is pending or running orders on vehicle.

## 5.22.8


### Changed (1 change)

- remove vehicle search by order uuid and parking io uuid

## 5.22.6


### Changed (1 change)

- search-vehicle return uuid.

## 5.22.4


### Changed (1 change)

- DB indexes.

## 5.22.2


### Fixed (1 change)

- Fix search vehicles

## 5.22.1


### Fixed (1 change)

- Update shape when dimensions are updated


## 5.22.0


### Changed (3 changes)

- Get parkingIO from airlock when updating the parkingIO status after an order succeeds.
- Move vehicle characteristics and dimensions to dedicated tabled.
- Remove algo lock when receiving parking io created message.


### Added (1 change)

- search vehicle by characteristics.

## 5.21.3
Use algo 2.21.1


## 5.21.2


### Fixed (1 change)

- Fix fk between orders and parking_io (on delete set null).

## 5.21.1


### Changed (1 change)

- Check at origin and destination lane type, and not order type for parkingIO status update.


### Fixed (1 change)

- Update parkingIO status and airlock states after an order is acknowledged.

## 5.21.0


### Added (7 changes)

- Call cerberus to end storage on airlock after the last order on airlock succeeds (airlock empty).
- Call cerberus to start restitution on airlock when the first exiting order starts.
- Call cerberus to start storage when the first storing order starts.
- Create new booleans valus in airlocks to stop using airlocks states directly.
- Listen FMS vehicle dimension update event.
- Receive AirlockDTO from Cerberus after start/end storage/restitution and use it to update airlock state.
- Receive AirlockDTO with updated values of the airlock after each call to cerberus, and update state in real time.


### Changed (1 change)

- Remove locked attribute from airlocks and drop locked column from lanes.


### Fixed (2 changes)

- Remove onDelete CASCADE from fk between order and parking_IO tables.
- Remove @Transactional before Algorithm calls in AirlockManager (avoids some bad transaction rollbacks).

## 5.20.0


### Added (1 change)

- Listen FMS vehicle dimension update event.

### Changed (1 change)

- Use algo 2.21.1


## 5.19.0
Use algo 2.21.0

### Added (1 change)

- Update orders priority after beginning or ending the assignment of an airlock to a parkingIO (IN or OUT).

## 5.18.6
Use algorithm 2.20.3


## 5.18.5


### Fixed (1 change)

- Remove redundant call to cerberus in multilane airlocks.

## 5.18.4


### Fixed (1 change)

- Fix vehicle characteristics update on parking IO creation.

## 5.18.3


### Added (1 change)

- Dont call cerberus to assign airlock for restitution if it is in state RESTITUTION_ONGOING (only for manual orders).

## 5.18.2


### Changed (1 change)

- Dont check offset consistency when deposing vehicles on a lane (avoids exceptions when default dimensions are used).

## 5.18.1


### Added (1 change)

- Add isAvailableForDeposit attribute in Airlock.

## 5.18.0


### Added (3 changes)

- Add endpoint to update vehicle characteristics by vin.
- CH-11614 capacity endpoint.
- Don't rollback a canceled / failed order if the vehicle is already out of the parking.


### Changed (2 changes)

- Add try-catch for order status processing (succeed, fails, etc.) to avoid transactions rollbacks.
- Expect meters from hermes.

## 5.17.0


### Added (1 change)

- Add area to vehicle dto.


### Fixed (2 changes)

- Fix missing call to cerberus for manual restitution orders.
- Prevent the deposit of vehicles greater than lane length with POST /lane/{laneName}/deposit.


### Changed (1 change)

- search vehicle API. !388

## 5.16.3


### Fixed (1 change)

- Fix missing call to cerberus for manual restitution orders.

## 5.16.2


### Fixed (1 change)

- Redundant call to cerberus

## 5.16.1


### Fixed (2 changes)

- Don't ask cerberus to asisgn for restitution if airlock state is already ASSIGNED_FOR_RESTITUTION.
- Move AlgorithmLock from OrderService to OrderListener.

## 5.16.0
Use algo 2.20.0

### Added (2 changes)

- Add directions IN, IN_OUT and OUT to airlocks.
- add GET /area/{name} endpoint.

## 5.15.1


### Fixed (1 change)

- Exclude succeeded / failed / canceled orders from getByParent function in OrderEngine.

## 5.15.0
Use algo 2.19.0

### Added (2 changes)

- add algorithm lock on ParkingIO controller to retrieve IO.
- Retrieve order dependencies & support multitype. !190


### Changed (2 changes)

- Don't start a restitution if one of the vehicles in the parkingIO is already involved in a parkingIO in progress.
- Remove findOrderByParent from OrderSearchService and use dependencies.


### Fixed (1 change)

- Fix area filter before assigning airlock after manual order.

## 5.14.2


### Added (1 change)

- Test for restitution to end on airlock after a manual order.

## 5.14.1


### Added (1 change)

- Assign airlock to a parkingIO if it contains only vehicles from the parkingIO (moved manually for instance).

## 5.14.0


### Added (2 changes)

- Add GET /lane?area={areaName}.
- Compute after an exiting order succeeds if restitution is completed on the airlock, if yes call cerberus to end restitution on it.

## 5.13.2


### Changed (1 change)

- Remove column parent dropping from orders table.

## 5.13.1


### Fixed (2 changes)

- Unassign airlocks to parkingIO if parkingIO is DONE and airlock goes to NOT_ASSIGNED.
- Unassigned airlock to parkingIO when it is emptied (even if parkingIO is not DONE).

## 5.13.0


### Removed (1 change)

- remove exception constructors with no parameter.

## 5.12.3


### Fixed (2 changes)

- Force airlock association with Parking IO when retrieve IO
- Set withOpening to true when retrieve IO


## 5.12.2


### Fixed (1 change)

- Unassign airlock only when vehicle retrieved


## 5.12.1


### Changed (1 change)

- Add parameter to specify parking io when depositing vehicle on lane


## 5.12.0


### Added (3 changes)

- Add endpoint to get parking io by assigned airlock.
- Add handover area and airlocks into parking io.
- Add nbVehicles in parking io.


### Changed (5 changes)

- Always update vehicle characteristics on parking io event.
- Change error json format.
- Change transactional behavior: remove transactional from algorithm calls and add them to basic transactions (create order and move vehicle, assign airlock, update priority, ...).
- Log algo version number.
- use parking io nbVehicles instead of parking io vehicle size to find airlock at deposit.


### Fixed (1 change)

- don't run housekeeping if airlock is already unlocked.

## 5.11.1


### Changed (1 change)

- Use algo 2.15.1 to stop automatic order creation on disabled lanes.

## 5.11.0
Use algorithm 2.15.0

### Added (3 changes)

- Add a scheduler for housekeeping.
- Add conditionnal property on RetrievalScheduler to disable automatic restitutions.
- get parkingIO endpoint. !361


### Changed (1 change)

- Turn all exceptions into RuntimeException.

## 5.10.2


### Fixed (1 change)

- Use algo 2.14.1 to fix case of storage orders on already stored vehicles.

## 5.10.1


### Changed (1 change)

- Remove GAP at deposit for minimum offset computation


## 5.10.0


### Added (3 changes)

- Add endpoint to get restitution candidate from a list of vehicles.
- Add find vehicle endpoint.
- Consider a parkingIO ready for restitution if all vehicles are on parking or if processing already started.


## 5.9.2


### Changed (1 change)

- Remove GAP at deposit for minimum offset computation


## 5.9.1


### Fixed (1 change)

- Fix vehicles characteristics source when sending it to FMS


## 5.9.0


### Added (2 changes)

- Add endpoint in vehicle api to fetch vehicle by vin.
- Add endpoint to get airlocks for deposit.
- Add events when vehicle location updated and when vehicle left

## 5.8.0


### Added (1 change)

- Send all vehicle characteristics and sources to FMS.


## 5.7.2
Use algo 2.13.2


## 5.7.1


### Fixed (1 change)

- Force persistence of parkingIO status after update.

## 5.7.0
Use algo 2.13.0

### Added (3 changes)

- Add area to parkingIO.
- Create relation between parkingIO and airlocks. Assign airlock for a parkingIO when airlock is assigned for restitution.
- Remove airlock from parkingIO if any once airlock goes from locked to unlocked.

## 5.6.0
Use algo 2.12.0

### Fixed (3 changes)

- Consider only undone orders when searching for orders by parent.
- Fix warn log in move vehicle when destination position is not reachable.
- update parkingio state at deposit.


### Changed (2 changes)

- Update list of ParkingIO status: SCHEDULED, DEPOSIT, IN_HANDOVER_AREA, WAITIN_AIRLOCK_ASSIGNMENT, AIRLOCK_ASSIGNED, IN_PROGRESS_, RETRIEVAL, DONE.
- Add VIN and remove unused columns on Vehicle. !9110

## 5.5.0
Use algo 2.11.0

### Added (3 changes)

- Add critical alert for bad vehicle movement (when vehicle is not on origin space).
- Add logs for bad parent/child order cancellation and rollback.
- Create endpoint to trigger retrieval for a parking IO.


### Changed (1 change)

- read vehicle characteristics from parking io event when creating vehicle.


### Fixed (1 change)

- Use same queue for failed and cancelled order events.

## 5.4.3


### Fixed (1 change)

- Send VehicleLeftEvent to fix booking state


## 5.4.2


### Fixed (1 change)

- Repare persistence of lane and vehicle state after exitVehicle.

## 5.4.1


### Fixed (3 changes)

- Delete related trajectory lengths when deleting a lane.
- Don't try to publish orders stats if stats are disabled.
- Fix transactions issues for exitVehicle.

## 5.4.0
Use algo 2.10.0

### Added (3 changes)

- Implement airlocks on Themis.
- publish stats on current state of the parking and on running/waiting orders.
- Publish stats on order when it succeeds / fails / is canceled.


### Changed (1 change)

- Remove locked state from lane and use airlock state instead.

## 5.3.1


### Removed (1 change)

- Remove exception when order priority update fails".

## 5.3.0


### Changed (2 changes)

- clean rotate180 geometry method.
- Get parkingIO from storing and exiting orders to update parkingIO status.


### Fixed (1 change)

- Don't check if ParkingIO IN exists before creating ParkingIO OUT.

## 5.2.1


### Added (1 change)

- Add IN_HANDOVER_AREA status to parkingIO when all orders succeeded but vehicles are still on the parking.

## 5.2.0
Use algorithm 2.8.0

### Added (1 change)

- Add status to parkingIO (SCHEDULED, AIRLOCK_ASSIGNED, IN_PROGRESS, DONE).


### Changed (1 change)

- Force to save vehicles in lane by ascending offset.

## 5.1.2


### Fixed (1 change)

- Fix algorithm scheduler.

## 5.1.1


### Fixed (1 change)

- Cancel order after rollback if it doesn't exist in database.

## 5.1.0
Use algorithm 2.7.0

### Added (2 changes)

- Add lock to order priorities updates.
- Create new class for scheduled calls to the algorithm.


### Removed (2 changes)

- Delete vehicle/{vehicleUuid}/deposit endpoint.
- Remove lane parameters from createVehicle method.


### Fixed (1 change)

- Fix shape update at order success.

## 5.0.0


### Fixed (3 changes)

- Add lock when calling exitVehicles.
- Fix duplicated associations between parkingIOs and vehicles.
- No rollback of transactions for AlgorithmFailureException.


### Changed (1 change)

- remove booking events and use parking io events instead.

## 4.3.2


### Fixed (1 change)

- Fix on VehicleCreatedEvent


## 4.3.1


### Fixed (1 change)

- Fix on VehicleDepositedEvent and VehicleCreatedEvent


## 4.3.0


### Added (1 change)

- Create VehicleDepositedEvent.


### Removed (2 changes)

- Delete BookingService and BookingLinkedToVehicleEvent.
- Remove srBookingId from ParkingIO, telemetry events and DTO.


### Changed (2 changes)

- divide parking io in IN and OUT movements.
- Extend ParkingIOs to list of vehicles.

## 4.2.1


### Added (1 change)

- Create new endpoint lane/LANENAME/depose to replace and unify vehicle creation process in themis + allow the use of vehicle/VEHICLEID/characteristics for cars not on the parking.

## 4.2.0


### Fixed (1 change)

- Fix UndeclaredThrowableException on loop on BookingCancelledEvent.


### Changed (3 changes)

- make offset optional for /sop-tools/move-vehicle and take it in meters.
- sop-tools/exit-booking renamed to exit-vehicle : uses vehicle uuid instead of srBookingId.
- use lanes and not spaces in trajectory length table.


### Removed (1 change)

- Remove all parking spaces related things.

## 4.1.5


### Fixed (1 change)

- Don't update locked status if it doesn't change.

## 4.1.4


### Added (1 change)

- Create order for manual move.

## 4.1.3


### Fixed (1 change)

- Synchronize AirlockLockedStateListener and AirlockRetrievedListener


### Changed (1 change)

- make restit date nullable in add-vehicles soptool endpoint

## 4.1.2


### Changed (1 change)

- Send sourceOffset to FMS when creating order.

## 4.1.1


### Added (1 change)

- Add endpoint to get shape for a vehicle at specific location with specific width and length.


### Changed (1 change)

- Return list of vehicles created in fill_lanes endpoint.


### Fixed (1 change)

- Send VehicleCreatedForBookingEvent in linkVehicleToBooking for /testing-tools/add-vehicles endpoint.

## 4.1.0


### Added (4 changes)

- Allow to specify any characteristic when creating a vehicle.
- Save vehicleTakeSide in the Order SQL table.
- Create vehicle with no lane at parkingIO creation, send VehicleCreatedForBooking event to hermes at vehicle creation, create new endpoint to attach vehicles to a lane.
- Use dedicated event to exit vehicles.


### Removed (3 changes)

- delete VehicleDetectedInCabinListener.
- remove field srBooking from vehicle, rename column name to a temporary one.
- remove srBookingId from VehicleDTO.


### Changed (1 change)

- update endpoint "add-vehicle" to create vehicles without booking or lane.

## 4.0.5


### Added (1 change)

- Add a PATCH method for vehicle characteristics to update only one or several characteristics at a time.


### Changed (1 change)

- Update algorithms version to 2.2.4.

## 4.0.4


### Changed (1 change)

- Update algorithms version to 2.2.3.


### Fixed (2 changes)

- update lane mode and locked state separately.
- Update lane properties after changing vehicle characteristics.

## 4.0.3


### Fixed (2 changes)

- Don't update lane mode depending and airlock state.
- Run housekeeping after a lane is enabled.


### Changed (1 change)

- Update algorithms to version 2.2.2.

## 4.0.2


### Changed (1 change)

- Update algorithms to 2.2.1.

## 4.0.1


### Fixed (1 changes)

- Don't exit vehicle if order are still in progress while airlock is unlocked


## 4.0.0


### Added (1 change)

- Allow to disable stats publishing through configuration.


### Fixed (2 changes)

- Don't process order status update if order is already in specified state.
- Update position and shape of vehicle when updating its characteristics.


### Changed (4 changes)

- Send new dynamic order request DTO to FMS.
- Update algorithms to 2.2.0.
- Update OrderDTO to add laneName and offset.
- connect Themis to Cerberus airlock API instead of Cabin API.

## 3.3.1


### Changed (1 change)

- Use algorithms version 2.1.1.


### Fixed (1 change)

- Various bug fixes for 3.3 release.

## 3.3.0


### Added (2 changes)

- Add randomization of overhang lengths and vehicle width.
- Expose vehicle characteristics in DTO and allow updating them in new endpoint.


### Fixed (1 change)

- Fix random vehicle length.


### Changed (1 change)

- Remove all waiting tags when adding an exiting tag.

## 3.2.2


### Fixed (1 change)

- bugfix: honour withOpening option passed by algorithm when processing housekeeping results.


### Changed (1 change)

- Use algorithms 2.0.1.

## 3.2.1


### Fixed (1 change)

- fix order type for exiting with opening.

## 3.2.0


### Added (3 changes)

- Add characteristics column to vehicle table.
- Add isEmpty / isFull in LaneDTO.
- Create VehicleCharacteristics to contain length, width, frontOverhang and rearOverhang.


### Fixed (2 changes)

- bugfix: set booking state to ARRIVED when adding vehicles in the parking.
- Fix error log when algorithm fail.


### Changed (2 changes)

- Read overhang lengths from config.
- Use algorithms 2.0.

## 3.1.1


### Fixed (3 changes)

- bugfix: send back laneName as parkingSpaceName in VehicleDTO when vehicle is in HANDOVER lanes.
- bugfix: send back retro-compat vehicle.parkingSpaceName in ParkingIOApi.
- Try to match an old parkingSpace in compatParkingSpaceName to repair achille tests.

## 3.1.0


### Added (4 changes)

- Add an endpoint to GET a vehicle by laneName and rankInLane.
- Add an endpoint to GET lanes by type.
- Create ThemisConfiguration.
- Send scaled vehicle shape to FMS when creating dynamic orders.


### Fixed (2 changes)

- bugfix: exception in processing one housekeeping action should not stop the loop.
- Fix shapes of vehicles in HANDOVER and DEPOSIT lanes.


### Changed (3 changes)

- Stop sending back the actual parkingSpaceName in VehicleDTO - dynamic lanes!
- Update createVehicle for dynamic lanes model.
- Update spring to 2.3.4.

## 3.0.1


### Added (1 change)

- Add a POST endpoint to disable all lanes except handover lanes.


### Fixed (1 change)

- bugfix: update lane mode properly when receiving availability message from cerberus.

## 3.0.0
Update algorithm with a new storage algorithm that finds the best lane and side with a scoring function

### Added (10 changes)

- Add a configuration item to randomize vehicle length in createVehicle.
- Add a GET vehicles endpoint to LaneController.
- Add a paginated endpoint to get all lanes.
- Add length to lane DTO.
- Add paginated GET /areas endpoint.
- Add rankInLane attribute to VehicleDTO.
- Add size, laneName and offset to vehicle DTO.
- Create a mock of FMS that you can switch on through config.
- Create Area object to group lanes.
- Send domain messages for lane creation / update / deletion.


### Changed (3 changes)

- Allow nullable offsets in DynamicOrderCreationRequest.
- Load lane shape and position from parking.json instead of computing it.
- Load trajectory_lengths from the FMS paths archive in GCS.


### Fixed (2 changes)

- Cancel child of order in processOrderCanceled.
- Fix cabin to cabin manual orders.

## 2.8.6


### Fixed (1 change)

- Fix fill-lanes endpoint

## 2.8.5


### Fixed (1 change)

- Bump to algorithms 1.10.2 to fix a bug in order chaining.


### Changed (1 change)

- Check for existing car on space in createVehicle.

## 2.8.4


### Added (1 change)

- Add testing endpoint to add vehicles at specific space in parking.


### Changed (1 change)

- Rename /add-vehicles-to-parking endpoint to /fill-lanes.

## 2.8.3


### Fixed (1 change)

- Fix bug in daily planning, for parking IOs without a vehicleId.

## 2.8.2


### Added (1 change)

- Allow creation of a batch of manual orders, disabling housekeeping in between.


### Fixed (2 changes)

- Fix destinationOffset in order rollback.
- Ignore locked status on non DEPOSIT lanes.

## 2.8.1


### Fixed (1 change)

- Fix manually triggered STORING and EXITING manual orders.

## 2.8.0


### Added (3 changes)

- Add locked column to Lane.
- Automatic chaining of manual orders.
- add a testing-tools endpoint to create multiple vehicles on parking. !156


### Changed (3 changes)

- Do not rollback loading parking when loading trajectories fails.
- remove specific events sent to and received from cerberus. !146
- use all vehicles on lane instead of vehicle id in cabin ready event. !157

## 2.7.5


### Fixed (1 change)

- fix: Honour the parent parameter in OrderCreationRequestDTO.

## 2.7.4


### Fixed (2 changes)

- Dont rollback transaction on HouseKeepingException in moveVehicle and exitVehicle.
- Fix deleteAllVehicles in VehicleService.

## 2.7.3

### Fixed (3 changes)

- Add @Transactional on onVehicleMoved and onVehicleLeft
- Fetch vehicle by id instead of srBookingId in receiveVehicleLeftEvent
- Add FetchType.EAGER to Lane
- Manually delete linked orders when deleting a ParkingSpace on reload


## 2.7.2


### Fixed (1 change)

- Refetch lane in VehicleService.exitVehicle to avoid LazyInitializationException.

## 2.7.1


### Changed (1 change)

- Do not fail parking-data reload when failing to load trajectory lengths.

## 2.7.0

Updated algorithms version to 1.9.0, which contains the following changes:
    - Add a config to disable WAITING_* tag processing.
    - Add size to vehicle.
    - Add some attributes to LaneInterface (length, sides, type, vehicles).
    - Extract retrievals from housekeeping.
    - Refactor housekeeping to execute it on vehicle movement.
    - Update parking space interface to make lane not nullable.
    - Fix the calculation of vehicle offset in nats engine listener.

### Added (2 changes)

- Add POST /sop-tools/retrievals endpoint to trigger retrievals.
- Add vehicle ling-to-booking endpoint for achille.


### Changed (5 changes)

- HouseKeeping runs when a vehicle moves or exits, the engine listens to HouseKeeping results to create corresponding orders.
- Update lane and vehicle to add shape.
- Update LaneDTO to add availableSpaceSides and type from zeus.
- Update lane dto to add length from zeus.
- Update parking space to make lane non nullabke.


### Fixed (1 change)

- Properly reset lanes when deleting all vehicles.
- Don't update manual order priority
- Run housekeeping when receiving a FREED event on a cabin

## 2.6.8


### Fixed (1 change)

- bugfix: deleting a vehicle on a space was deleting the associated space, fix that.


### Changed (1 change)

- Split /clean endpoint in 3 different endpoints for each object type.

## 2.6.7


### Added (3 changes)

- Add endpoints to enable / disable all lanes.
- Listen to BookingCancelledEvent to delete vehicle parking io.
- 5759: Create endpoint to clean data. !119


### Fixed (1 change)

- bugfix: vehicle tag processing was not done for manual orders.


### Changed (1 change)

- Update algorithms to 1.7.5

## 2.6.6


### Fixed (1 change)

- bugfix: fetch Vehicle entity in OrderService to repair vehicle tags.

## 2.6.5


### Fixed (1 change)

- Add EAGER fetch type to tags.

## 2.6.4


### Fixed (1 change)

- bugfix in parent / child relationship of orders created by chain of retrievals.


### Changed (1 change)

- Use multiple threads for scheduled tasks.

## 2.6.3

### Changed (1 change)

- Update algorithms to 1.7.3


## 2.6.2

### Changed (1 change)

- Update algorithms to 1.7.2.


## 2.6.1

### Changed (1 change)

- Update algorithms to 1.7.1 which contains the following:
    - bugfix: findSpaceAfterVehicleExitingBetween was checking for free spaces and not available spaces.


## 2.6.0


### Added (2 changes)

- add origin and destination spaces details on order creation request.
- Load trajectory lengths in ParkingDataLoader service.


### Changed (1 change)

- Update algorithms to 1.7.0 which contains the following:
    - Add possibility to limit the number of vehicles exiting within a short period of time in a lane.
    - In housekeeping, anticipate retrievals if multiple vehicles are exiting in a lane.
    - bugfix: filling partially filled CLOSE_TO_CABINS lanes in the right order.
    - bugfix: there were issues on adding the NEEDS_TO_BE_MOVED tag.
    - Cleanup and add comments to storage policies.


## 2.5.6

### Fixed (1 change)

- Fix swagger

## 2.5.5

### Changed (1 change)

- Slightly optimize isAtHead/Tail vehicle search in ParkingEngine


## 2.5.4


### Changed (1 change)

- Update algorithms to 1.6.2 - more logging.


## 2.5.3


### Changed (1 change)

- Send booking and vehicle ids when preparing cabin for restitution

## 2.5.2


### Changed (1 change)

- Use algorithms 1.6.1 which contains:
- Cleanup storage policies and add comments

## 2.5.1


### Fixed (1 change)

- bugfix: call prepareCabinForRestitution on manual exiting order creation.

## 2.5.0


### Added (3 changes)

- Add endpoint to get parking IOs between two instants.
- Add SOP tools endpoints to get / set parking mode.
- Implement new distance API between spaces / lanes.


### Changed (4 changes)

- Change doudou FX value depending on parking mode (normal / rush).
- Defer vehicle tag creation and removal to algorithms module.
- Prepare cabin for restitution before order creation.
- Use algorithms 1.6.0 which contains:
    - Add parameter to LaneSearch to filter lanes by their tags.
    - Handle tagging vehicles when no cabins / no storage space etc..., this was done by themis before.
    - Implement RushModeStoragePolicy.
    - Migrate order priority calculation here, was in themis before.
    - When in rush mode, only do retrievals.
    - Sort by distance when opening a new lane - try to exclude rush mode lanes. !58


### Fixed (1 change)

- Fix ParkingDataLoader to load lane tags from parking-data.

## 2.4.3


### Changed (1 change)

- Add anticipation for retrievals. !90
- Update algorithms to 1.5.1 which contains the following:
    - Add anticipation for retrievals.

## 2.4.2


### Fixed (2 changes)

- Fix vehicle reset issue. !91
- Add out date anticipation for parkingIO creation. !94

## 2.4.1


### Changed (1 change)

- Listen to new BookingInOutDatesChangedEvent.

## 2.4.0


### Added (2 changes)

- Add datadog agent.
- add createdAt, startedAt and endedAt field on order events. !82


### Fixed (1 change)

- Fix issues with calculation of priorities for car retrievals (exiting and exiting_with_opening). !81


### Changed (3 changes)

- Deduct time before exiting to compute restitutionDateTime. !84
- Delete associated orders when deleting spaces on data reload. !86
- Update algorithms to 1.5.0 which contains the following:
    - Exit vehicles in increasing rank order when multiple vehicles are exiting in one lane.
    - Housekeeping triggers optimizations until a few hours before restitution.


## 2.3.0


### Changed (1 change)

- Use algorithms version 1.4.2 which contains the following:
    - Reintroduce minimum delay between cars for SAME_DAY_LANES policy.


### Added (4 changes)

- Create SQL table to record parking in/out movements in advance. !76
- Add originSpace and originSpaceType to VehicleMovedEvent. !77
- Implement ParkingIOEngineApi. !78
- Listen to BookingParkingInDateChangedEvent to update ParkingIO table. !80

## 2.2.1

### Changed (1 change)

- Use algorithms version 1.4.1, which contains the following
    - bugfix: dont create multiple exiting orders on one lane

## 2.2.0

### Added (6 changes)

- Add endpoint to retrieve pages of parking spaces. !66
- Add position and shape column to parking_space table. !68
- Add position and shape on vehicle if it has a space. !68
- Expose tags in ParkingSpaceDTO. !68
- Add endpoint to retrieve spaces by type. !72
- Send telemetry for order success / cancel / fail. !73
- Publish new stat: exit time difference between vehicles in FIFO lanes. !75


### Changed (1 change)

- Use algorithms version 1.4.0, which contains the following
    - New (inactive for now) storage policy (DELTA_T_THRESHOLD) to only open new lane above a time threshold.
    - New stat: time differences between vehicles in FIFO lanes.
    - bugfix: stop housekeeping from re-storing vehicles on disabled buffers.

## 2.1.2

### Changed (1 change)

- Bump algorithms version to 1.3.2
    - Stop housekeeping from re-storing vehicles on disabled buffers

### Fixed (2 change)

- check space availability when creating manual order. !63
- check if exiting with opening order exists before creating it !63

## 2.1.1


### Changed (1 change)

- Bump algorithms version to 1.3.1.
    - Fix double optimization not triggered when vehicles are in rank 1 and rank 2.

## 2.1.0


### Changed (2 changes)

- Use algorithms 1.3.0
    - Add function to calculate cabin occupation stats.
    - Move implementation of computeReachableSides from themis to here
    - bugfix: Some lane configurations did not trigger a double optimization.
    - Create new SAME_DAY_LANES storage policy.

- Give back WAITING_EXITING vehicles according to restitutionDateTime. !57


### Added (1 change)

- Publish cabin occupation ratio stats. !61

## 2.0.7


### Fixed (1 change)

- Fix bug when computing reachability of destination space on manual order creation.

## 2.0.6

### Fixed (2 changes)

- Housekeeping : fix check for undone orders on exiting with opening causing multiple orders created on same vehicle
- Manual order creation : sides are not anymore mandatory on space with only one side available

## 2.0.5


### Fixed (1 change)

- Fix canceling child orders when parent failed

## 2.0.4


### Changed (1 change)

- Bump algorithms version to 1.1.2.

## 2.0.3


### Changed (1 change)

- use version 1.1.1 of standard algorithm

### Fixed (1 change)

- setup cabin to waiting storage after canceling exiting order


## 2.0.2


### Fixed (3 changes)

- Fix force-execution-date endpoint
- Fix run housekeeping endpoint
- Force cabin state when ack order

## 2.0.1


### Fixed (1 change)

- Fix order canceling

### Changed (2 changes)

- remove WAITING_* tags when vehicle left parking
- enable swagger documentation

## 2.0.0


### Added (3 changes)

- handle FMS communication. !24
- Add SOP tools endpoint to move vehicle on parking. !38
- Give possibility to stop optimization / vehicle storing from buffers. !43

## 1.5.2


### Added (1 change)

- STS-95: add endpoint to find orders from a list of uuids. !53

## 1.5.1


### Added (1 change)

- Shadow order creation for housekeeping actions. !36

## 1.5.0


### Added (2 changes)

- add endpoint to check id space is free and reachable from specified side.
- Add endpoint to reset vehicles. !32
- Shadow storage and retrieval algorithms with new implementation

## 1.4.0


### Changed (1 change)

- exitBooking is now a POST request.


### Added (2 changes)

- add order priority service. !23
- Handle Tag on vehicle, lane and parking space. !27

## 1.3.3

# Fixed (1 change)

- Fix NATS order API mapping


## 1.3.2


### Changed (1 change)

- Listen to event from Hermes instead of Nats to update parking out date of vehicle. !26

## 1.3.1


# Fixed (1 change)

- Fix order to dto conversion
- Fix NATS order API mapping

## 1.3.0


### Added (3 changes)

- Add exitBooking endpoint for SOP. !20
- Add endpoints for order management from nats. !21
- Add GET /vehicle endpoint to retrieve all vehicles. !23

## 1.2.2


### Added (1 change)

- Exit vehicle when receiving a FREE SpaceDepositAvailabilityEvent. !22

## 1.2.1

### Added (1 change)

- Listen to VehicleLeftEvent !19
- Add parkingSpaceType to VehicleDTO !18

## 1.2.0

Important release - communication with cerberus, nats and atlas is now mainly done through rabbitMQ messages.

### Added (1 change)

- Add endpoint to retrieve vehicle by space name. !16

## 1.1.0


### Added (2 changes)

- add endpoint to retrieve orders with sr booking id. !11
- add endpoint to retrieve vehicle data with sr booking id. !11


































