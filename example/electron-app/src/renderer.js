const { SerialPort } = require('serialport')
const { createApp, ref } = require('vue')

createApp({
  setup() {
    const ports = ref([])
    const couter = ref(0)

    SerialPort.list().then((list) => {
      ports.value = list.map((p) => p.path)
    })

    const selectedPort = ref('COM1')
    const isConnected = ref(false)
    const isLedOn = ref(false)

    let port = null

    const connect = () => {
      if (!selectedPort.value) {
        alert('Please select a port')
        return
      }

      port = new SerialPort({
        path: selectedPort.value,
        baudRate: 9600
      })

      port.on('open', () => {
        console.log('Port opened')
        isConnected.value = true
      })

      port.on('data', (data) => {
        if (data.toString() === 'S')
          couter.value += 1
        else if (data.toString() === 'O')
          isLedOn.value = true
        else if (data.toString() === 'F')
          isLedOn.value = false
      })

      port.on('error', (err) => {
        console.log('Error:', err)
        isConnected.value = false
      })
    }

    if (isConnected.value) {
      console.log('Connected')
    }

    const disconnect = () => {
      if (!isConnected.value) return alert('Not connected')
      port.close()
      isConnected.value = false
    }

    const turnOn = () => {
      if (!isConnected.value) return alert('Not connected')
      port.write('@')
    }

    const turnOff = () => {
      if (!isConnected.value) return alert('Not connected')
      port.write('$')
    }

    return { ports, selectedPort, connect, disconnect, isConnected, couter, turnOn, turnOff, isLedOn }
  },

  template: `
    <main class='min-h-screen flex flex-col items-center justify-center bg-white text-black'>
      <h1 class='text-2xl font-bold mb-4'>Communication Interface</h1>

      <div class='grid grid-cols-2 gap-4'>
        <div class='flex flex-col items-center p-4 border border-gray-300 rounded'>
          <select v-model='selectedPort' class='p-2 border border-gray-300 rounded'>
            <option value='null' disabled>Select a port</option>
            <option v-for='port in ports' :value='port'>{{ port }}</option>
          </select>

          <button class='mt-4 p-2 bg-blue-500 text-white rounded' @click='connect' v-if='!isConnected'>
            Connect
          </button>

          <button class='mt-4 p-2 bg-red-500 text-white rounded' @click='disconnect' v-if='isConnected'>
            Disconnect
          </button>
        </div>

        <div class='flex flex-col items-center p-4 border border-gray-300 rounded' v-if='isConnected'>
          <p>Counter: {{ couter }}</p>

          <div class='flex items-center justify-center gap-4'>
            <button class='mt-4 p-2 bg-green-500 text-white rounded disabled:opacity-50' @click='turnOn' :disabled='isLedOn'>Turn On</button>
            <button class='mt-4 p-2 bg-red-500 text-white rounded disabled:opacity-50' @click='turnOff' :disabled='!isLedOn'>Turn Off</button>
          </div>
        </div>
      </div>  
    </main>
  `
}).mount('#app')