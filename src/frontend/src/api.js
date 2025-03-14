import {HttpAgent, Actor} from "@dfinity/agent";
import { idlFactory } from "@dfinity/agent/lib/cjs/canisters/management_service";

const agent = new HttpAgent({ host: "http://127.0.0.1:4943"})

const registroCanister = Actor.createActor(idlFactory, {agent, canisterId: "be2us-64aaa-aaaaa-qaabq-cai"});

export async function verCalificacion() {
    return await registroCanister.verCalificacion();
}

export async function agregarCalificacion(materiaId, calif) {
    return await registroCanister.agregarCalificacion(materiaId, calif);   
};