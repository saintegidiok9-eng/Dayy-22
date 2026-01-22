enum RoomStatus 
{
  available,
  occupied
}

class Room 
{
  final int number;
  final String type;
  RoomStatus _status = RoomStatus.available;

  Room(this.number, this.type);

  bool get isAvailable => _status == RoomStatus.available;

  void occupy() 
  {
    _status = RoomStatus.occupied;
  }

  void free() 
  {
    _status = RoomStatus.available;
  }
}

class Booking 
{
  final String guestName;
  final Room room;
  final int nights;

  Booking(this.guestName, this.room, this.nights);
}

class Hotel 
{
  final String name;
  final List<Room> _rooms = [];
  final List<Booking> _bookings = [];

  Hotel(this.name);

  void addRoom(Room room) 
  {
    _rooms.add(room);
  }

  Booking? bookRoom(String guestName, String type, int nights) 
  {
    for (var room in _rooms) 
    {
      if (room.type == type && room.isAvailable) 
      {
        room.occupy();
        Booking booking = Booking(guestName, room, nights);
        _bookings.add(booking);
        return booking;
      }
    }
    return null;
  }

  void checkout(Booking booking) 
  {
    booking.room.free();
    _bookings.remove(booking);
  }

  void printStatus() 
  {
    for (var room in _rooms) 
    {
      print(
        "Room ${room.number} (${room.type}) - "
        "${room.isAvailable ? "Available" : "Occupied"}"
      );
    }
  }
}

void main() 
{
  Hotel hotel = Hotel("Sunrise Hotel");

  hotel.addRoom(Room(101, "Single"));
  hotel.addRoom(Room(102, "Single"));
  hotel.addRoom(Room(201, "Double"));

  Booking? b1 = hotel.bookRoom("Ama", "Single", 2);
  Booking? b2 = hotel.bookRoom("Kojo", "Single", 1);

  if (b1 != null) 
  {
    print("${b1.guestName} booked room ${b1.room.number}");
  }

  if (b2 == null) 
  {
    print("No Single rooms available");
  }

  hotel.printStatus();
}
