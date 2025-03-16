import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";
import { createServerClient } from "@supabase/ssr";

export async function updateSession(request: NextRequest) {
  try {
    // Create a Supabase client
    const { supabaseClient } = createServerClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
      {
        cookies: {
          get: (key) => request.cookies.get(key)?.value,
          set: (key, value, options) => {
            // This code will never run in middleware, because we won't actually set cookies here
          },
          remove: (key, options) => {
            // This code will never run in middleware, because we won't actually remove cookies here
          },
        },
      }
    );

    // This will refresh session if expired - required for Server Components
    // https://supabase.com/docs/guides/auth/server-side/nextjs
    await supabaseClient.auth.getUser();

    return NextResponse.next({
      request: {
        headers: request.headers,
      },
    });
  } catch (e) {
    console.error("Supabase client creation failed in middleware:", e);

    // Return an error response or redirect to an error page
    return NextResponse.redirect(
      new URL("/error?reason=auth_service_unavailable", request.url)
    );

    // Alternatively, if you prefer to continue but log the error:
    // console.error('Supabase client creation failed:', e);
    // return NextResponse.next({
    //   request: {
    //     headers: request.headers,
    //   },
    // });
  }
}
