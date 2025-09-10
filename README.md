# bitcrshr's dotfiles

This flake defines the shared configuration and packages that I want all of my machines to share. It
is also set up so that other flakes (e.g., a private one for work) can inherit from it easily.

### Structure

- `archetypes`
  - System-specific config that is shared among all machines of that system type
- `hosts`
  - Host-specific config
- `modules`
  - Spot for things like home manager config that will be common across all machines
- `lib`
  - Exposes custom functions for easily defining configurations in other flakes
- `flake-parts`
  - Defines exports and also the actual systems this flake manages

### Motivation

I have been using a fully terminal based development environment for a few years now, and I was starting
to get really frustrated with having to update my personal laptops and servers every time I made some kind
of change to my workflow.

Instead, I decided I would pour hours into learning Nix well enough to write this and save *dozens* of minutes
*every year*!

Jokes aside, this setup has been serving me well and I intend to continue improving it over time. Obviously,
it is highly tailored towards my own needs, but perhaps the general structure could be useful to someone else.
