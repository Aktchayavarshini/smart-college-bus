import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "CampusRide — Smart College Bus Allocation",
  description: "Plan your campus commute with live college bus availability.",
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
