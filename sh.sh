#!/bin/bash

# Sauvegarder les modifications actuelles dans le répertoire de travail
git stash save "Temporary changes"

# Récupérer la liste de toutes les branches locales
branches=$(git branch | sed 's/^[* ] //')

# Parcourir chaque branche
for branch in $branches; do
    # Passer à la branche
    git checkout $branch
    
    # Récupérer les modifications depuis le stash
    git stash pop
    
    # Ajouter les modifications à l'index
    git add .
    
    # Commiter les modifications
    git commit -m "Apply modification to $branch"
    
    # Sauvegarder de nouveau les modifications restantes si elles existent
    git stash save "Remaining changes for $branch"
done

# Revenir à la branche initiale (optionnel)
initial_branch=$(git branch | grep '^\*' | sed 's/^\* //')
git checkout $initial_branch

# Appliquer les modifications restantes
git stash pop
