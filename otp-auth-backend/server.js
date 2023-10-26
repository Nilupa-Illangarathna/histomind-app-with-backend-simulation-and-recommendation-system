const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const uuid = require('uuid'); // Import the uuid library

const app = express();
app.use(bodyParser.json());
app.use(cors());

const users = [
  { username: 'user1', email: 'user1@gmail.com', password: 'pass1' ,user_id: "id01"},
  { username: 'user2', email: 'user2@gmail.com', password: 'pass2' ,user_id: "id02"},
];




const nearbyAttractions = [
  {
    imageUrl: 'https://picsum.photos/700/700?random=8',
    name: 'Photographer 8',
    dateTime: 'Daytime photography',
    description: 'Description for photo 8',
    locationID: 'locID1',
  },
  {
    imageUrl: 'https://picsum.photos/700/700?random=9',
    name: 'Photographer 9',
    dateTime: 'Daytime photography',
    description: 'Description for photo 9',
    locationID: 'locID2',
  },
  {
    imageUrl: 'https://picsum.photos/700/700?random=10',
    name: 'Photographer 10',
    dateTime: 'Daytime photography',
    description: 'Description for photo 10',
    locationID: 'locID3',
  },
  {
    imageUrl: 'https://picsum.photos/700/700?random=11',
    name: 'Photographer 11',
    dateTime: 'Daytime photography',
    description: 'Description for photo 11',
    locationID: 'locID4',
  },
  {
    imageUrl: 'https://picsum.photos/700/700?random=12',
        name: 'Photographer 12',
    dateTime: 'Daytime photography',
    description: 'Description for photo 12',
    locationID: 'locID5',
  },
  {
    imageUrl: 'https://picsum.photos/700/700?random=13',
        name: 'Photographer 13',
    dateTime: 'Daytime photography',
    description: 'Description for photo 13',
    locationID: 'locID6',
  },
  {
    imageUrl: 'https://picsum.photos/700/700?random=14',
        name: 'Photographer 14',
    dateTime: 'Daytime photography',
    description: 'Description for photo 14',
    locationID: 'locID7',
  },
  // Add more nearby attractions
];

const recommendedLocations = [
  {
    imageUrl: 'https://picsum.photos/700/700?random=1',
    name: 'Photographer 1',
    dateTime: 'Abstract photography',
    description: 'Description for photo 1',
    locationID: 'loc11',
  },
  {
    imageUrl: 'https://picsum.photos/700/700?random=2',
    name: 'Photographer 2',
    dateTime: 'Abstract photography',
    description: 'Description for photo 2',
    locationID: 'loc12',
  },
  {
    imageUrl: 'https://picsum.photos/700/700?random=3',
    name: 'Photographer 3',
    dateTime: 'Abstract photography',
    description: 'Description for photo 3',
    locationID: 'loc13',
  },
  {
    imageUrl: 'https://picsum.photos/700/700?random=4',
    name: 'Photographer 4',
    dateTime: 'Abstract photography',
    description: 'Description for photo 4',
    locationID: 'loc14',
  },
  {
    imageUrl: 'https://picsum.photos/700/700?random=5',
    name: 'Photographer 5',
    dateTime: 'Abstract photography',
    description: 'Description for photo 5',
    locationID: 'loc15',
  },
  {
    imageUrl: 'https://picsum.photos/700/700?random=6',
    name: 'Photographer 6',
    dateTime: 'Abstract photography',
    description: 'Description for photo 6',
    locationID: 'loc16',
  },
  {
    imageUrl: 'https://picsum.photos/700/700?random=7',
    name: 'Photographer 7',
    dateTime: 'Abstract photography',
    description: 'Description for photo 7',
    locationID: 'loc17',
  },
  // Add more recommended locations
];

// Sample Location data
class Location {
  constructor(id, place, lat, lon) {
    this.id = id;
    this.place = place;
    this.lat = lat;
    this.lon = lon;
  }
}

const Locations1 = [
  new Location(0, "Colombo Galle Face Sri Lanka", 6.9319, 79.8478),
  new Location(1, "Kalaniya Temple Sri Lanka", 6.9585, 79.9580),
  new Location(2, "Mawanella Town Sri Lanka", 7.2689, 80.3418),
  new Location(3, "Temple of Tooth Sri Lanka", 7.2921, 80.6448),
];

const Locations2 = [
  new Location(0, "Delhi, India", 28.6139, 77.2090),
  new Location(1, "Jaipur, India", 26.9124, 75.7873),
  new Location(2, "Agra, India", 27.1767, 78.0081),
  new Location(3, "Varanasi, India", 25.3176, 82.9739),
  new Location(4, "Mumbai, India", 19.0760, 72.8777),
  new Location(5, "Bengaluru, India", 12.9716, 77.5946),
];

const Locations3 = [
  new Location(0, "New York, USA", 40.7128, -74.0060),
  new Location(1, "Los Angeles, USA", 34.0522, -118.2437),
  new Location(2, "Chicago, USA", 41.8781,  -87.6298),
  new Location(3, "San Francisco, USA", 37.7749, -122.4194),
  new Location(4, "Miami, USA",  25.7617, -80.1918),
  new Location(5, "Las Vegas, USA", 36.1699, -115.1398),
];


// Login endpoint
app.post('/login', (req, res) => {
  const { username, password } = req.body;

  console.log('All users:', users); // Add this line to print the users array

  const user = users.find((u) => u.username === username && u.password === password);

  if (user) {
    // If user is found, send the success response with user_id
    res.json({ success: true, user_id: user.user_id });
  } else {
    res.status(401).json({ success: false, message: 'Invalid username or password' });
  }
});


// Signup endpoint
// Handle user registration
app.post('/signup', (req, res) => {
  const inputUsername = req.body.username;
  const inputEmail = req.body.email;
  const inputPassword = req.body.password;

  // Check if the provided username or email already exists
  const userExists = users.some(user => user.username === inputUsername || user.email === inputEmail);

  if (userExists) {
    return res.status(400).json({ message: 'User already exists.' });
  }

  // Generate a UUID for the new user
  const user_id = uuid.v4();

  // Create a new user object and add it to the users array
  const newUser = {
    username: inputUsername,
    email: inputEmail,
    password: inputPassword,
    user_id,
  };

  users.push(newUser);

  // Return the username and user_id to the client
  res.status(200).json({ username: inputUsername, user_id });
});




// Define an endpoint to fetch data
app.get('/getInitData', (req, res) => {
  const arrayName = req.query.arrayName;
  if (arrayName === 'Nearby_Attractions') {
    res.json({ Nearby_Attractions: nearbyAttractions });
  } else if (arrayName === 'Recommendations') {
    res.json({ Recommendations: recommendedLocations });
  } else {
    res.status(404).json({ error: 'Array not found' });
  }
});



const LocationsList = [Locations1, Locations2, Locations3];

// Define a route that returns a random Location list
app.post('/PathMap', (req, res) => {
  const locationData = req.body;
  console.log('Received LocationAndUserDataToPassed object:');
  console.log(locationData);
  // console.log("Request recieved");
  const randomListIndex = Math.floor(Math.random() * LocationsList.length);
  const randomLocationList = LocationsList[randomListIndex];
  res.json(randomLocationList);
});



const port = 3000;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
