#!/usr/bin/env python3
"""
Repository Language Analysis Script
Analyzes all repositories in the current directory to generate language statistics
"""

import os
import json
from pathlib import Path
from collections import defaultdict, Counter

def count_lines_in_file(file_path):
    """Count lines in a file, handling encoding issues gracefully"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            return sum(1 for line in f if line.strip())
    except (UnicodeDecodeError, IOError):
        try:
            with open(file_path, 'r', encoding='latin-1') as f:
                return sum(1 for line in f if line.strip())
        except:
            return 0

def get_language_from_extension(ext):
    """Map file extensions to programming languages"""
    language_map = {
        '.js': 'JavaScript',
        '.jsx': 'JavaScript',
        '.ts': 'TypeScript',
        '.tsx': 'TypeScript',
        '.html': 'HTML',
        '.htm': 'HTML',
        '.css': 'CSS',
        '.scss': 'SCSS',
        '.sass': 'Sass',
        '.py': 'Python',
        '.java': 'Java',
        '.cpp': 'C++',
        '.c': 'C',
        '.cs': 'C#',
        '.php': 'PHP',
        '.rb': 'Ruby',
        '.go': 'Go',
        '.rs': 'Rust',
        '.swift': 'Swift',
        '.kt': 'Kotlin',
        '.scala': 'Scala',
        '.r': 'R',
        '.sql': 'SQL',
        '.sh': 'Shell',
        '.bash': 'Shell',
        '.json': 'JSON',
        '.xml': 'XML',
        '.yaml': 'YAML',
        '.yml': 'YAML',
        '.md': 'Markdown',
        '.vue': 'Vue.js',
        '.svelte': 'Svelte'
    }
    return language_map.get(ext.lower(), 'Other')

def analyze_repository(repo_path):
    """Analyze a single repository for language statistics"""
    repo_name = os.path.basename(repo_path)
    language_stats = defaultdict(int)
    file_count = defaultdict(int)
    
    # Skip .git and node_modules directories
    skip_dirs = {'.git', 'node_modules', '.next', 'build', 'dist', '__pycache__', '.vscode', '.idea'}
    
    for root, dirs, files in os.walk(repo_path):
        # Remove skip directories from dirs list
        dirs[:] = [d for d in dirs if d not in skip_dirs]
        
        for file in files:
            file_path = Path(root) / file
            ext = file_path.suffix
            
            if ext:  # Only process files with extensions
                language = get_language_from_extension(ext)
                lines = count_lines_in_file(file_path)
                language_stats[language] += lines
                file_count[language] += 1
    
    return repo_name, dict(language_stats), dict(file_count)

def generate_repo_analysis():
    """Generate analysis for all repositories"""
    parent_dir = Path(__file__).parent.parent
    repositories = []
    total_stats = defaultdict(int)
    
    print("🔍 Analyzing repositories...")
    
    for item in parent_dir.iterdir():
        if item.is_dir() and item.name != 'DarrylClay2005':
            repo_name, lang_stats, file_counts = analyze_repository(item)
            
            if lang_stats:  # Only include repos with code
                repositories.append({
                    'name': repo_name,
                    'languages': lang_stats,
                    'file_counts': file_counts,
                    'total_lines': sum(lang_stats.values())
                })
                
                # Add to total stats
                for lang, lines in lang_stats.items():
                    total_stats[lang] += lines
    
    # Sort repositories by total lines (descending)
    repositories.sort(key=lambda x: x['total_lines'], reverse=True)
    
    return repositories, dict(total_stats)

def generate_markdown_report(repositories, total_stats):
    """Generate a markdown report of the analysis"""
    report = []
    report.append("# 📊 Repository Language Analysis\n")
    
    # Overall statistics
    report.append("## 🌟 Overall Language Distribution\n")
    sorted_langs = sorted(total_stats.items(), key=lambda x: x[1], reverse=True)
    
    for lang, lines in sorted_langs[:10]:  # Top 10 languages
        percentage = (lines / sum(total_stats.values())) * 100
        report.append(f"- **{lang}**: {lines:,} lines ({percentage:.1f}%)")
    
    report.append("\n## 📁 Repository Details\n")
    
    for repo in repositories[:15]:  # Top 15 repositories
        report.append(f"### 📂 {repo['name']}")
        report.append(f"**Total Lines**: {repo['total_lines']:,}\n")
        
        # Top languages in this repo
        sorted_repo_langs = sorted(repo['languages'].items(), key=lambda x: x[1], reverse=True)
        for lang, lines in sorted_repo_langs[:5]:  # Top 5 languages per repo
            percentage = (lines / repo['total_lines']) * 100
            report.append(f"- {lang}: {lines:,} lines ({percentage:.1f}%)")
        
        report.append("")
    
    return "\n".join(report)

if __name__ == "__main__":
    repositories, total_stats = generate_repo_analysis()
    
    # Save analysis to JSON
    with open('repo_analysis.json', 'w') as f:
        json.dump({
            'repositories': repositories,
            'total_statistics': total_stats,
            'summary': {
                'total_repositories': len(repositories),
                'total_lines_of_code': sum(total_stats.values()),
                'languages_used': len(total_stats)
            }
        }, f, indent=2)
    
    # Generate markdown report
    markdown_report = generate_markdown_report(repositories, total_stats)
    with open('REPO_ANALYSIS.md', 'w') as f:
        f.write(markdown_report)
    
    print(f"✅ Analysis complete!")
    print(f"📊 Analyzed {len(repositories)} repositories")
    print(f"📝 Total lines of code: {sum(total_stats.values()):,}")
    print(f"🔤 Languages detected: {len(total_stats)}")
    print(f"📄 Reports saved: repo_analysis.json, REPO_ANALYSIS.md")
