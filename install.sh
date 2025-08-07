#!/bin/bash

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on Arch Linux
check_arch() {
    if [ ! -f /etc/arch-release ]; then
        log_error "This script is designed for Arch Linux. Exiting."
        exit 1
    fi
    log_success "Arch Linux detected"
}

update_system() {
    log_info "Updating system packages..."
    sudo pacman -Syu --noconfirm
    log_success "System updated"
}

install_base_packages() {
    log_info "Installing base packages..."
    
    local packages=(
        # Core Hyprland and Wayland
        "hyprland"
        "hyprpaper" 
        "hyprlock"
        "hypridle"
        "hyprshot"
        
        # Audio
        "pipewire"
        "pipewire-audio"
        "pipewire-pulse"
        "wireplumber"
        "pavucontrol"
        "playerctl"
        
        # Display and graphics
        "brightnessctl"
        "wl-clipboard"
        "grim"
        "slurp"
        
        # File manager and utilities
        "dolphin"
        "ghostty"  # Your terminal - may need AUR
        "brave-bin"  # Your browser - AUR package
        "vscodium-bin"  # AUR package
        
        # Notification and bar
        "waybar"
        "swaync"
        "wofi"
        
        # Development and tools
        "git"
        "curl"
        "wget"
        "unzip"
        "fastfetch"
        
        # Fonts
        "ttf-jetbrains-mono"
        "ttf-jetbrains-mono-nerd"
        "noto-fonts"
        "noto-fonts-emoji"
        
        # Shell and terminal tools
        "zsh"
        "starship"
    )
    
    pacman_packages=()
    aur_packages=()
    
    for package in "${packages[@]}"; do
        if pacman -Si "$package" &>/dev/null; then
            pacman_packages+=("$package")
        else
            aur_packages+=("$package")
        fi
    done
    
    if [ ${#pacman_packages[@]} -gt 0 ]; then
        log_info "Installing packages from official repositories..."
        sudo pacman -S --needed --noconfirm "${pacman_packages[@]}"
    fi
    
    log_success "Base packages installed"
}

install_yay() {
    if command -v yay &> /dev/null; then
        log_info "yay is already installed"
        return
    fi
    
    log_info "Installing yay AUR helper..."
    
    # Install base-devel if not present
    sudo pacman -S --needed --noconfirm base-devel git
    
    # Clone and install yay
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
    
    log_success "yay installed successfully"
}

install_aur_packages() {
    log_info "Installing AUR packages..."
    
    local aur_packages=(
        "ghostty"
        "brave-bin"
        "vscodium-bin"
    )
    
    for package in "${aur_packages[@]}"; do
        if ! yay -Qi "$package" &>/dev/null; then
            log_info "Installing $package from AUR..."
            yay -S --noconfirm "$package" || log_warning "Failed to install $package"
        else
            log_info "$package is already installed"
        fi
    done
    
    log_success "AUR packages installation completed"
}

setup_zinit() {
    log_info "Setting up Zinit for Zsh..."
    
    if [ ! -d "${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git" ]; then
        mkdir -p "$(dirname "${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git")"
        git clone https://github.com/zdharma-continuum/zinit.git "${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
        log_success "Zinit installed"
    else
        log_info "Zinit is already installed"
    fi
}

create_config_dirs() {
    log_info "Creating configuration directories..."
    
    local dirs=(
        "$HOME/.config/hypr"
        "$HOME/.config/waybar" 
        "$HOME/.config/wofi"
        "$HOME/.config/ghostty"
        "$HOME/.config/fastfetch"
        "$HOME/.config/wallpapers"
    )
    
    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
    done
    
    log_success "Configuration directories created"
}

copy_configs() {
    log_info "Copying configuration files..."
    
    # Check if config files exist in current directory
    local config_files=(
        ".config/hypr/hyprland.conf"
        ".config/hypr/hyprlock.conf"  
        ".config/hypr/hyprpaper.conf"
        ".config/hypr/hypridle.conf"
        ".config/waybar/config.jsonc"
        ".config/waybar/style.css"
        ".config/waybar/reload.sh"
        ".config/wofi/style.css"
        ".config/ghostty/config"
        ".config/fastfetch/config.jsonc"
        ".config/dolphinrc"
        ".zshrc"
    )
    
    for config in "${config_files[@]}"; do
        if [ -f "$config" ]; then
            mkdir -p "$HOME/$(dirname "$config")"
            cp "$config" "$HOME/$config"
            log_info "Copied $config"
        else
            log_warning "$config not found in current directory"
        fi
    done
    
    # Make waybar reload script executable
    if [ -f "$HOME/.config/waybar/reload.sh" ]; then
        chmod +x "$HOME/.config/waybar/reload.sh"
    fi
    
    log_success "Configuration files copied"
}

setup_wallpapers() {
    log_info "Setting up wallpapers..."
    
    mkdir -p "$HOME/.config/wallpapers"
    
    if [ ! -f "$HOME/.config/wallpapers/some-anime-girls.jpg" ]; then
        log_info "Default wallpaper not found. You'll need to add your wallpaper to ~/.config/wallpapers/some-anime-girls.jpg"
        echo "# Add your wallpaper here: ~/.config/wallpapers/some-anime-girls.jpg" > "$HOME/.config/wallpapers/README.txt"
    fi
    
    log_success "Wallpaper directory setup completed"
}

setup_fastfetch_logo() {
    log_info "Setting up fastfetch..."
    
    if [ ! -f "$HOME/.config/fastfetch/logo.png" ]; then
        log_info "Fastfetch logo not found. You'll need to add your logo to ~/.config/fastfetch/logo.png"
        echo "# Add your logo here: ~/.config/fastfetch/logo.png" > "$HOME/.config/fastfetch/README.txt"
    fi
    
    log_success "Fastfetch setup completed"
}

setup_zsh() {
    log_info "Setting up Zsh as default shell..."
    
    if [ "$SHELL" != "/usr/bin/zsh" ]; then
        chsh -s /usr/bin/zsh
        log_success "Default shell changed to Zsh (restart required)"
    else
        log_info "Zsh is already the default shell"
    fi
}

enable_services() {
    log_info "Enabling system services..."
    
    systemctl --user enable --now pipewire.service
    systemctl --user enable --now pipewire-pulse.service
    systemctl --user enable --now wireplumber.service
    
    log_success "Services enabled"
}

setup_keyboard() {
    log_info "Setting up Polish keyboard layout..."
    
    sudo localectl set-keymap pl
    
    log_success "Keyboard layout configured"
}

print_final_instructions() {
    log_success "Installation completed!"
    echo
    log_info "Final steps:"
    echo "1. Logout and select Hyprland as your session"
    echo "2. Add your wallpaper to ~/.config/wallpapers/some-anime-girls.jpg"
    echo "3. Add your fastfetch logo to ~/.config/fastfetch/logo.png"
    echo "4. Restart your system or run 'exec zsh' to use the new shell"
    echo
    log_info "Key bindings (from your config):"
    echo "- Super + Q: Terminal (ghostty)"
    echo "- Super + B: Browser (brave)"
    echo "- Super + F: File manager (dolphin)"
    echo "- Super + J: VS Codium"
    echo "- Super + Space: Application menu (wofi)"
    echo "- Super + L: Lock screen"
    echo "- Print: Screenshot window"
    echo "- Shift + Print: Screenshot region"
    echo "- Ctrl + Print: Screenshot output"
    echo
    log_info "Configuration files are located in ~/.config/"
    log_info "You can customize them according to your needs."
}

main() {
    log_info "Starting Hyprland desktop environment installation..."
    echo
    
    check_arch
    update_system
    install_yay
    install_base_packages
    install_aur_packages
    setup_zinit
    create_config_dirs
    copy_configs
    setup_wallpapers
    setup_fastfetch_logo
    setup_zsh
    enable_services
    setup_keyboard
    
    echo
    print_final_instructions
}

main "$@"
