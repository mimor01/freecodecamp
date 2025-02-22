--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: game_info; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.game_info (
    games_played integer,
    best_game integer,
    username character varying(22) NOT NULL
);


ALTER TABLE public.game_info OWNER TO freecodecamp;

--
-- Data for Name: game_info; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.game_info VALUES (9, 1, 'Milan');
INSERT INTO public.game_info VALUES (2, 620, 'user_1740227707441');
INSERT INTO public.game_info VALUES (5, 444, 'user_1740227707442');
INSERT INTO public.game_info VALUES (2, 574, 'user_1740227835340');
INSERT INTO public.game_info VALUES (5, 151, 'user_1740227835341');
INSERT INTO public.game_info VALUES (2, 484, 'user_1740227898038');
INSERT INTO public.game_info VALUES (5, 530, 'user_1740227898039');


--
-- PostgreSQL database dump complete
--

