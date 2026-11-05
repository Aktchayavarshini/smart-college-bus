"use client";

import { useEffect, useMemo, useState } from "react";
import { ArrowRight, BusFront, CalendarDays, Clock3, MapPin, Route, ShieldCheck, Users } from "lucide-react";

type Stop = { id: number; name: string; area: string; description?: string };
type Trip = {
  tripId: number;
  busNumber: string;
  routeName: string;
  source: string;
  destination: string;
  travelDate: string;
  departureTime: string;
  arrivalTime?: string;
  availableSeats: number;
  totalSeats: number;
  driverName?: string;
  pickupStopName?: string;
  dropoffStopName?: string;
  estimatedTravelMinutes?: number;
};

const apiBase = process.env.NEXT_PUBLIC_API_BASE_URL?.replace(/\/$/, "");

function localDate() {
  const now = new Date();
  const offset = now.getTimezoneOffset();
  return new Date(now.getTime() - offset * 60_000).toISOString().slice(0, 10);
}

export default function HomePage() {
  const [stops, setStops] = useState<Stop[]>([]);
  const [trips, setTrips] = useState<Trip[]>([]);
  const [travelDate, setTravelDate] = useState(localDate());
  const [timeSlot, setTimeSlot] = useState("ALL");
  const [pickup, setPickup] = useState("");
  const [dropoff, setDropoff] = useState("");
  const [loadingStops, setLoadingStops] = useState(true);
  const [searching, setSearching] = useState(false);
  const [searched, setSearched] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    if (!apiBase) {
      setError("Connect the Spring Boot API by setting NEXT_PUBLIC_API_BASE_URL.");
      setLoadingStops(false);
      return;
    }
    fetch(`${apiBase}/api/v1/stops`, { credentials: "include" })
      .then(async (response) => {
        if (!response.ok) throw new Error("Could not load pickup stops.");
        return response.json() as Promise<Stop[]>;
      })
      .then(setStops)
      .catch((reason: Error) => setError(reason.message))
      .finally(() => setLoadingStops(false));
  }, []);

  const canSearch = useMemo(() => Boolean(travelDate && pickup && dropoff && pickup !== dropoff), [travelDate, pickup, dropoff]);

  async function searchTrips(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    if (!apiBase || !canSearch) return;
    setSearching(true);
    setError("");
    setSearched(true);
    const query = new URLSearchParams({ travelDate, preferredTimeSlot: timeSlot });
    if (pickup) query.set("pickupStopId", pickup);
    if (dropoff) query.set("dropoffStopId", dropoff);
    try {
      const response = await fetch(`${apiBase}/api/v1/trips?${query.toString()}`, { credentials: "include" });
      if (!response.ok) throw new Error(response.status === 400 ? "Choose a valid travel date and try again." : "Trip search is temporarily unavailable.");
      setTrips(await response.json() as Trip[]);
    } catch (reason) {
      setTrips([]);
      setError(reason instanceof Error ? reason.message : "Something went wrong.");
    } finally {
      setSearching(false);
    }
  }

  return (
    <main className="min-h-screen overflow-hidden">
      <header className="mx-auto flex max-w-7xl items-center justify-between px-5 py-6 lg:px-8">
        <a href="/" className="flex items-center gap-3">
          <span className="flex h-11 w-11 items-center justify-center rounded-2xl bg-navy text-white"><BusFront size={23} /></span>
          <span><span className="block text-lg font-black tracking-tight text-ink">CampusRide</span><span className="block text-[10px] font-bold uppercase tracking-[0.22em] text-slate-400">Smart campus transit</span></span>
        </a>
        <nav className="hidden items-center gap-8 text-sm font-semibold text-slate-500 md:flex">
          <a className="transition hover:text-navy" href="#find-bus">Find a bus</a>
          <a className="transition hover:text-navy" href="#how-it-works">How it works</a>
          <a className="transition hover:text-navy" href={apiBase ? `${apiBase}/login` : "#find-bus"}>Student login <ArrowRight className="ml-1 inline" size={14} /></a>
        </nav>
        <a href={apiBase ? `${apiBase}/login` : "#find-bus"} className="rounded-full bg-navy px-5 py-3 text-sm font-bold text-white shadow-lg shadow-blue-950/10 transition hover:-translate-y-0.5 hover:bg-blue-900">Sign in</a>
      </header>

      <section className="relative mx-auto grid max-w-7xl items-center gap-12 px-5 pb-16 pt-10 lg:grid-cols-[1.02fr_.98fr] lg:px-8 lg:pb-24 lg:pt-16">
        <div className="absolute -left-40 top-10 -z-10 h-96 w-96 rounded-full bg-sky blur-3xl" />
        <div>
          <div className="mb-7 inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-bold text-navy shadow-sm"><span className="h-2 w-2 rounded-full bg-emerald-500" /> A smarter way to get to campus</div>
          <h1 className="max-w-2xl text-5xl font-black leading-[1.06] tracking-[-0.055em] text-ink sm:text-6xl lg:text-7xl">Your campus commute, <span className="text-blue-600">under control.</span></h1>
          <p className="mt-7 max-w-xl text-lg leading-8 text-slate-500">Find the right college bus, choose your pickup and drop-off stops, and check seat availability before you travel.</p>
          <div className="mt-9 flex flex-wrap gap-6 text-sm font-semibold text-slate-500">
            <span className="flex items-center gap-2"><ShieldCheck size={18} className="text-blue-600" /> Verified seat availability</span>
            <span className="flex items-center gap-2"><Route size={18} className="text-blue-600" /> Flexible stops</span>
          </div>
        </div>
        <div className="relative">
          <div className="absolute -right-10 -top-12 h-64 w-64 rounded-full bg-blue-100/80 blur-3xl" />
          <div className="relative rounded-[2rem] border border-white bg-white p-3 shadow-soft">
            <div className="overflow-hidden rounded-[1.5rem] bg-gradient-to-br from-[#12365f] via-[#174b7c] to-[#3984bc] p-7 text-white sm:p-9">
              <div className="flex items-center justify-between"><span className="text-xs font-bold uppercase tracking-[0.2em] text-blue-100">Campus transit</span><BusFront size={24} /></div>
              <div className="mt-12 max-w-sm"><p className="text-3xl font-extrabold leading-tight tracking-tight">Every journey starts with a better plan.</p><p className="mt-3 text-sm leading-6 text-blue-100">A single place to discover routes and plan your daily ride.</p></div>
              <div className="mt-10 flex items-center gap-3 rounded-2xl border border-white/15 bg-white/10 p-4 backdrop-blur"><div className="flex h-10 w-10 items-center justify-center rounded-xl bg-white text-navy"><MapPin size={20} /></div><div><p className="text-xs text-blue-100">Your next destination</p><p className="font-bold">College campus</p></div><ArrowRight className="ml-auto" size={19} /></div>
            </div>
            <div className="grid grid-cols-3 gap-2 p-3 text-center">
              <div className="rounded-xl bg-mist p-3"><BusFront className="mx-auto text-blue-700" size={19} /><p className="mt-2 text-xs font-bold text-ink">Bus routes</p></div>
              <div className="rounded-xl bg-mist p-3"><Users className="mx-auto text-blue-700" size={19} /><p className="mt-2 text-xs font-bold text-ink">Seat counts</p></div>
              <div className="rounded-xl bg-mist p-3"><Clock3 className="mx-auto text-blue-700" size={19} /><p className="mt-2 text-xs font-bold text-ink">Time slots</p></div>
            </div>
          </div>
        </div>
      </section>

      <section id="find-bus" className="mx-auto max-w-7xl scroll-mt-8 px-5 pb-20 lg:px-8">
        <div className="rounded-[2rem] border border-blue-100 bg-white p-6 shadow-soft sm:p-9">
          <div className="mb-7 flex flex-wrap items-end justify-between gap-4"><div><p className="text-xs font-black uppercase tracking-[0.2em] text-blue-600">Plan your ride</p><h2 className="mt-2 text-3xl font-black tracking-tight text-ink">Find your college bus</h2><p className="mt-2 text-sm text-slate-500">Choose your date, pickup location, drop-off location and departure time to see matching trips.</p></div><span className="rounded-full bg-sky px-4 py-2 text-xs font-bold text-navy">Live search</span></div>
          <form onSubmit={searchTrips} className="grid gap-4 md:grid-cols-2 xl:grid-cols-5">
            <label className="block"><span className="mb-2 flex items-center gap-2 text-xs font-bold text-slate-500"><CalendarDays size={15} /> Travel date</span><input required type="date" min={localDate()} value={travelDate} onChange={(e) => setTravelDate(e.target.value)} className="h-13 w-full rounded-xl border border-slate-200 bg-white px-4 py-3 text-sm font-semibold text-ink outline-none transition focus:border-blue-500 focus:ring-4 focus:ring-blue-50" /></label>
            <label className="block"><span className="mb-2 flex items-center gap-2 text-xs font-bold text-slate-500"><MapPin size={15} /> Pickup stop</span><select required value={pickup} onChange={(e) => { setPickup(e.target.value); if (e.target.value === dropoff) setDropoff(""); }} disabled={loadingStops} className="w-full rounded-xl border border-slate-200 bg-white px-4 py-3 text-sm text-ink outline-none focus:border-blue-500"><option value="">Select pickup location</option>{stops.map((stop) => <option key={stop.id} value={stop.id}>{stop.name} · {stop.area}</option>)}</select></label>
            <label className="block"><span className="mb-2 flex items-center gap-2 text-xs font-bold text-slate-500"><MapPin size={15} /> Drop-off stop</span><select required value={dropoff} onChange={(e) => setDropoff(e.target.value)} disabled={loadingStops} className="w-full rounded-xl border border-slate-200 bg-white px-4 py-3 text-sm text-ink outline-none focus:border-blue-500"><option value="">Select drop-off location</option>{stops.map((stop) => <option key={stop.id} value={stop.id}>{stop.name} · {stop.area}</option>)}</select></label>
            <label className="block"><span className="mb-2 flex items-center gap-2 text-xs font-bold text-slate-500"><Clock3 size={15} /> Departure time</span><select value={timeSlot} onChange={(e) => setTimeSlot(e.target.value)} className="w-full rounded-xl border border-slate-200 bg-white px-4 py-3 text-sm text-ink outline-none focus:border-blue-500"><option value="ALL">Any time</option>{["06:00","07:00","08:00","09:00","10:00","12:00","15:00","17:00"].map((slot) => <option key={slot} value={slot}>{slot}</option>)}</select></label>
            <button disabled={!canSearch || searching || !apiBase} className="mt-auto flex min-h-[48px] items-center justify-center gap-2 rounded-xl bg-blue-600 px-5 py-3 text-sm font-extrabold text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-50">{searching ? "Searching…" : "Search buses"} <ArrowRight size={17} /></button>
          </form>
          {error && <p role="status" className="mt-5 rounded-xl border border-amber-200 bg-amber-50 px-4 py-3 text-sm font-medium text-amber-800">{error}</p>}
          {searched && !searching && !error && <div className="mt-8"><div className="mb-4 flex items-center justify-between"><h3 className="text-lg font-extrabold text-ink">Matching trips</h3><span className="text-sm text-slate-500">{trips.length} found</span></div>{trips.length === 0 ? <div className="rounded-2xl bg-mist p-8 text-center text-sm text-slate-500">No scheduled buses match those preferences. Try another time or stop.</div> : <div className="grid gap-4 lg:grid-cols-2">{trips.map((trip) => <article key={trip.tripId} className="rounded-2xl border border-slate-200 p-5 transition hover:border-blue-200 hover:shadow-md"><div className="flex items-start justify-between gap-4"><div><p className="text-xs font-bold uppercase tracking-wider text-blue-600">{trip.routeName || "College route"}</p><h4 className="mt-1 text-xl font-black text-ink">Bus {trip.busNumber}</h4></div><span className={`rounded-full px-3 py-1.5 text-xs font-bold ${trip.availableSeats > 0 ? "bg-emerald-50 text-emerald-700" : "bg-rose-50 text-rose-700"}`}>{trip.availableSeats > 0 ? `${trip.availableSeats} seats left` : "Full"}</span></div><div className="mt-5 grid grid-cols-[1fr_auto_1fr] items-center gap-3"><div><p className="text-2xl font-black text-ink">{trip.departureTime?.slice(0,5)}</p><p className="mt-1 text-xs text-slate-500">{trip.pickupStopName || trip.source}</p></div><div className="h-px w-10 bg-blue-200" /><div className="text-right"><p className="text-2xl font-black text-ink">{trip.arrivalTime?.slice(0,5) || "—"}</p><p className="mt-1 text-xs text-slate-500">{trip.dropoffStopName || trip.destination}</p></div></div><div className="mt-5 flex items-center justify-between border-t border-slate-100 pt-4 text-xs text-slate-500"><span>{trip.totalSeats} total seats · {trip.driverName || "Driver details on booking"}</span><span>{trip.estimatedTravelMinutes ? `${trip.estimatedTravelMinutes} min` : "Scheduled"}</span></div></article>)}</div>}</div>}
        </div>
      </section>

      <section id="how-it-works" className="mx-auto max-w-7xl px-5 pb-24 lg:px-8"><div className="mb-10 max-w-xl"><p className="text-xs font-black uppercase tracking-[0.2em] text-blue-600">Simple by design</p><h2 className="mt-3 text-3xl font-black tracking-tight text-ink">Three steps to a smoother commute.</h2></div><div className="grid gap-5 md:grid-cols-3">{[{n:"01",title:"Choose your date",desc:"Start with the day you need to travel and select a departure window.",icon:CalendarDays},{n:"02",title:"Pick your stops",desc:"Find a route that works for your pickup and drop-off locations.",icon:MapPin},{n:"03",title:"Check availability",desc:"Review remaining seats before continuing to the existing secure booking flow.",icon:ShieldCheck}].map((step) => <div key={step.n} className="rounded-3xl border border-slate-200 bg-white p-7"><div className="flex items-center justify-between"><step.icon size={25} className="text-blue-600" /><span className="text-sm font-black text-blue-200">{step.n}</span></div><h3 className="mt-8 text-xl font-extrabold text-ink">{step.title}</h3><p className="mt-3 text-sm leading-6 text-slate-500">{step.desc}</p></div>)}</div></section>
      <footer className="border-t border-slate-200 bg-white"><div className="mx-auto flex max-w-7xl flex-col gap-3 px-5 py-8 text-xs text-slate-400 sm:flex-row sm:items-center sm:justify-between lg:px-8"><span className="font-bold text-slate-500">CampusRide · Smart College Bus Allocation System</span><span>Designed for a more reliable campus commute.</span></div></footer>
    </main>
  );
}
