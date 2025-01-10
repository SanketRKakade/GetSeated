import logo from './logo.svg';
import './App.css';
import pict from "./assets/pict.jpg"
import QRCode from 'react-qr-code';

function App() {
  const value = "https://youtube.com"
  return (
    <div className="App">
      <header className="App-header">
        Get Seated
      </header>
      <div class="maindiv" style={{backgroundImage:`url(${pict})`, backgroundSize:"cover", backgroundColor:"rgba(255, 255, 255, 0.1)"}}>
        <div class="qrcodecontainer">
            {/* <img src="" height="450px" width="450px" alt="this is qr"/> */}
            <QRCode
            size={250}
              value={value}
            />
        </div >

        <div class="container">
          <div className='labels'>

          <p>Occupied Seats</p>
          <p>Available Seats </p>
          </div>
          <div className='capacity'>

            <div class="occupied">
                <p>100</p>
            </div>
            <div class="available">
                <p>20</p>
            </div>
          </div>
        </div>
    </div>
    </div>
  );
}

export default App;
