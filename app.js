let listaNombres = [];

function agregarAmigo() {
    const input = document.getElementById('amigo');
    const nombre = input.value.trim();

    if (nombre === '') {
        alert('Por favor, ingresa un nombre válido.');
        return;
    }

    listaNombres.push(nombre);
    input.value = '';
    actualizarLista();
}

function actualizarLista() {
    const ul = document.getElementById('listaAmigos');
    ul.innerHTML = '';

    listaNombres.forEach((nombre) => {
        const li = document.createElement('li');
        li.innerText = nombre;
        ul.appendChild(li);
    });
}

function sortearAmigo() {
    if (listaNombres.length === 0) {
        alert('No hay nombres en la lista para sortear.');
        return;
    }

    const indiceAleatorio = Math.floor(Math.random() * listaNombres.length);
    const amigoSecreto = listaNombres[indiceAleatorio];

    const resultadoUl = document.getElementById('resultado');
    resultadoUl.innerHTML = ''; // Limpiar resultado previo

    const li = document.createElement('li');
    li.innerText = `El amigo secreto es: ${amigoSecreto} 🎉`;
    resultadoUl.appendChild(li);
}
